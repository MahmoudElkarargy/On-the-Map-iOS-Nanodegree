//
//  PostNewPinViewController.swift
//  On the Map
//
//  Created by Abdalla Elshikh on 4/24/20.
//  Copyright © 2020 Abdalla Elshikh. All rights reserved.
//

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
        print("Find me")
    }
    
    @IBAction func cancelPressed(_ sender: Any) {
        print("Cancel")
        self.dismiss(animated: true, completion: nil)
    }
    
}
