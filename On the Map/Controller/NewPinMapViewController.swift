import UIKit
import MapKit

class NewPinMapViewController: UIViewController, MKMapViewDelegate {
    @IBOutlet weak var mapView: MKMapView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureView()
    }
    
    func configureView(){
        self.mapView.delegate = self
        viewLocation(completion: displayPinOnMap(location:))
    }
    
    @IBAction func finishPressed(_ sender: Any) {
        //post new pin, add it to data and go back to map
        postLocation()
    }
    
    func postLocation(){
        //check if location doesn't exist POST it, if it does PUT it
        if StudentsModel.currentStudentData?.location == nil{
            StudentsModel.currentStudentData?.location = StudentsModel.postLocation
        User.PostStudentLocation(uniqueKey: User.userID, firstName: StudentsModel.currentStudentData?.firstName ?? "", lastName: StudentsModel.currentStudentData?.lastName ?? "", mapString: StudentsModel.postLocation, mediaURL: StudentsModel.postWebsite, latitude: StudentsModel.postLatitude! , Longitude: StudentsModel.postLongitude! , completionHandler: {
                (success, error) in
                if !success{
                    //show alert
                    self.showAlert(title: "Error", message: "Can't post location")
                }else{
                    //dismiss
                    self.dismiss(animated: true, completion: nil)
            }
            })
        }else{
            //if location exists PUT it
            let alertVC = UIAlertController(title: "Location Exists", message: "Do you want to update existing location? ", preferredStyle: .alert)
            alertVC.addAction(UIAlertAction(title: "Yes", style: .default, handler: handleExistingLocation(action:)))
            alertVC.addAction(UIAlertAction(title: "Cancel", style: .default, handler:handleExistingLocation(action:)))
            self.present(alertVC, animated: true)
        }
    }
    
    func handleExistingLocation(action: UIAlertAction){
        //update existing location
        if(action.title == "Yes"){
            User.PUTStudentLocation(uniqueKey: User.userID, firstName: StudentsModel.currentStudentData?.firstName ?? "", lastName: StudentsModel.currentStudentData?.lastName ?? "", mapString: StudentsModel.postLocation, mediaURL: StudentsModel.postWebsite, latitude: StudentsModel.postLatitude!, Longitude: StudentsModel.postLongitude!, completionHandler: {
                (success, error) in
                if !success{
                    //show alert
                    self.showAlert(title: "Error", message: "Can't update location")
                }else{
                    //dismiss
                    self.dismiss(animated: true, completion: nil)
                }
            })
        }else{
            self.dismiss(animated: true, completion: nil)
        }
    }
}

extension NewPinMapViewController{

    //customize pins
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        let reuseId = "pin"
        var pinView = mapView.dequeueReusableAnnotationView(withIdentifier: reuseId) as? MKPinAnnotationView
        if pinView == nil {
            pinView = MKPinAnnotationView(annotation: annotation, reuseIdentifier: reuseId)
            pinView?.isEnabled = true
            pinView!.canShowCallout = true
            pinView!.pinTintColor = .red
            pinView?.animatesDrop = true
            return pinView
        }
        else {
            pinView!.annotation = annotation
        }
        return pinView
    }
    
    func showAlert(title: String, message: String) {
        let alertVC = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alertVC.addAction(UIAlertAction(title: "Ok", style: .default, handler: {(action) in
            self.navigationController?.popViewController(animated: true)
        }))
        self.present(alertVC, animated: true)
    }
    
    
    func displayPinOnMap(location: CLLocationCoordinate2D?){
        //parse data
        guard let location = location else{
            //show alert
            showAlert(title: "Wrong Location", message: "This location cannot be found")
            return
        }
        //create a variable for annotations
        let lat = CLLocationDegrees(location.latitude)
        let long = CLLocationDegrees(location.longitude)
        //update current student new location data
        StudentsModel.postLatitude = lat
        StudentsModel.postLongitude = long
        // The lat and long are used to create a CLLocationCoordinates2D instance.
        let coordinate = CLLocationCoordinate2D(latitude: lat, longitude: long)
        // Here we create the annotation and set its coordiate, title, and subtitle properties
        let annotation = MKPointAnnotation()
        annotation.coordinate = coordinate
        annotation.title = "\(StudentsModel.postLocation)"
        // Finally we place the annotation in an array of annotations.
        self.mapView.addAnnotation(annotation)
        self.mapView.setCenter(coordinate, animated: true)
    }
    
    func viewLocation(completion: @escaping (CLLocationCoordinate2D?) -> Void) {
        let location = StudentsModel.postLocation
        let geocoder = CLGeocoder()
        geocoder.geocodeAddressString(location) {
            (placemarks, error) in
            if let placemarks = placemarks{
                completion(placemarks.first?.location?.coordinate)
            }else{
                completion(nil)
            }
        }
    }
}
