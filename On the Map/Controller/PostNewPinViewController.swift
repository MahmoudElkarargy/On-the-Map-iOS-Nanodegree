import UIKit

class PostNewPinViewController: UIViewController {
    
    let textFieldDelegate = LoginTextFieldsDelegate()
    @IBOutlet weak var locationTextField: UITextField!
    @IBOutlet weak var websiteTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.configureView()
    }
    
    func configureView(){
        self.locationTextField.delegate = textFieldDelegate
        self.websiteTextField.delegate = textFieldDelegate
    }
    
    @IBAction func findLocationPressed(_ sender: Any) {
        //if location exists, show it on map
        StudentsModel.postLocation = self.locationTextField.text ?? ""
        StudentsModel.postWebsite = self.locationTextField.text ?? ""
        performSegue(withIdentifier: "ShowLocation", sender: nil)
    }
    
    @IBAction func cancelPressed(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
}
