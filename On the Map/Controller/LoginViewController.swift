//
//  ViewController.swift
//  On the Map
//
//  Created by Abdalla Elshikh on 4/24/20.
//  Copyright © 2020 Abdalla Elshikh. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController {

    @IBOutlet weak var loginFailedLabel: UILabel!
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var loginActivityIndicator: UIActivityIndicatorView!
    let fieldsDelegate = LoginTextFieldsDelegate()

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        self.configureView()
    }
    
    func configureView(){
        self.emailTextField.delegate = fieldsDelegate
        self.passwordTextField.delegate = fieldsDelegate
    }

    @IBAction func signUp(_ sender: Any) {
        //direct to udacity website
        UIApplication.shared.open(User.Endpoints.signUP.url, options: [:], completionHandler: nil)
    }
    
    
    @IBAction func loginButtonPressed(_ sender: Any) {
        //authenticate login
        loginActivityIndicator.startAnimating()
        User.login(username: self.emailTextField.text ?? "" , password: self.passwordTextField.text ?? "" , completionHandler: self.authenticateLogin(success:error:))
    }
    
    func authenticateLogin(success: Bool, error: Error?) -> Void {
        loginActivityIndicator.stopAnimating()
        if(success){
            self.loginFailedLabel.text = "" //if there's any warning remove it
            User.getStudentData(completionHandler: parseStudentData(data:error:)) // get student data
            performSegue(withIdentifier: "AuthenticateLogin", sender: nil)
        }else{
            if(StudentsModel.credentialsError){
                self.loginFailedLabel.text = "Invalid Credentials"
            }else{
                self.loginFailedLabel.text = "Failed to Connect"
            }
        }
    }
    
    func parseStudentData(data: StudentDataResponse?, error: Error?){
        guard let data = data else {
            return
        }
        StudentsModel.currentStudentData = data
    }
}

