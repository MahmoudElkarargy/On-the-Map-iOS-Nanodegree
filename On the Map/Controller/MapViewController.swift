//
//  MapViewController.swift
//  On the Map
//
//  Created by Abdalla Elshikh on 4/24/20.
//  Copyright © 2020 Abdalla Elshikh. All rights reserved.
//

import UIKit
import MapKit

class MapViewController: UIViewController, MKMapViewDelegate {

    @IBOutlet weak var mapView: MKMapView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureView()
    }
    
    func configureView(){
        self.mapView.delegate = self
        self.tabBarController?.navigationItem.hidesBackButton = true
        self.tabBarController?.navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Logout", style: .plain, target: self, action: #selector(logoutIsPressed))
        self.tabBarController?.navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(named: "icon_addpin"), style: .plain, target: self, action: #selector(addNewPin))
        refreshData()
    }
    
    func refreshData(){
        User.getStudentsLocations(completionHandler: displayLocations(data:error:))
    }
    
    @IBAction func refreshPressed(_ sender: Any) {
        refreshData()
    }
    
    func displayPinsOnMap(){
        //parse data
        //if there are pins remove them from map
        if self.mapView.annotations.count > 0 {
            self.mapView.removeAnnotations(self.mapView.annotations)
        }
        let locations = StudentsModel.data
        var annotations = [MKPointAnnotation]()
        for dictionary in locations {
            let lat = CLLocationDegrees(dictionary.latitude)
            let long = CLLocationDegrees(dictionary.longitude)
            // The lat and long are used to create a CLLocationCoordinates2D instance.
            let coordinate = CLLocationCoordinate2D(latitude: lat, longitude: long)
            let first = dictionary.firstName
            let last = dictionary.lastName
            let mediaURL = dictionary.mediaURL
            // Here we create the annotation and set its coordiate, title, and subtitle properties
            let annotation = MKPointAnnotation()
            annotation.coordinate = coordinate
            annotation.title = "\(first) \(last)"
            annotation.subtitle = mediaURL
            // Finally we place the annotation in an array of annotations.
            annotations.append(annotation)
         }
         // When the array is complete, we add the annotations to the map.
        self.mapView.addAnnotations(annotations)
        self.mapView.reloadInputViews()
    }

    @objc func logoutIsPressed(){
        User.logout(completionHandler: {
            (success, error) in
            if success{
                self.tabBarController?.navigationController?.popViewController(animated: true)
            }else{
                self.showAlert(title: "Server Error", message: "Couldn't logout")
            }
        })
    }
    
    func showAlert(title: String, message: String) {
        let alertVC = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alertVC.addAction(UIAlertAction(title: "Ok", style: .default, handler: nil))
        self.present(alertVC, animated: true)
    }
    
    func displayLocations(data: StudentsLocations?, error: Error?){
        if let data = data{
            StudentsModel.data = data.results
            //display pins on map
            displayPinsOnMap()
        }else{
            //error fetching data
            showAlert(title: "Server Error", message: "Cannot fetch data")
        }
    }
    
    @objc func addNewPin(){
        performSegue(withIdentifier: "PostNewPin", sender: nil)
    }
}

extension MapViewController{
    //customize pins
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        let reuseId = "pin"
        var pinView = mapView.dequeueReusableAnnotationView(withIdentifier: reuseId) as? MKPinAnnotationView
        if pinView == nil {
            pinView = MKPinAnnotationView(annotation: annotation, reuseIdentifier: reuseId)
            pinView?.isEnabled = true
            pinView!.canShowCallout = true
            pinView?.animatesDrop = true
            pinView!.pinTintColor = .red
            pinView!.rightCalloutAccessoryView = UIButton(type: .detailDisclosure)
            return pinView
        }
        else {
            pinView!.annotation = annotation
        }
        return pinView
    }
    
    // This delegate method is implemented to respond to taps. as to direct to media type
    func mapView(_ mapView: MKMapView, annotationView view: MKAnnotationView, calloutAccessoryControlTapped control: UIControl) {
        if control == view.rightCalloutAccessoryView {
            let app = UIApplication.shared
            if let toOpen = view.annotation?.subtitle! {
                app.open(URL(string: toOpen)!, options: [:], completionHandler: nil)
            }
        }
    }
    
}
