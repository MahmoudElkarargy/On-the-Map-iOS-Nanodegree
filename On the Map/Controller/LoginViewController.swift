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

    @IBAction func loginButtonPressed(_ sender: Any) {
        //authenticate login
        loginActivityIndicator.startAnimating()
        User.login(username: self.emailTextField.text ?? "" , password: self.passwordTextField.text ?? "" , completionHandler: self.authenticateLogin(success:error:))
    }
    
    func authenticateLogin(success: Bool, error: Error?) -> Void {
        loginActivityIndicator.stopAnimating()
        if(success){
            self.loginFailedLabel.text = ""
            performSegue(withIdentifier: "AuthenticateLogin", sender: nil)
        }else{
            self.loginFailedLabel.text = "Invalid Credentials"
        }
    }
    
}
