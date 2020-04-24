//
//  LoginTextFieldsDelegate.swift
//  On the Map
//
//  Created by Abdalla Elshikh on 4/24/20.
//  Copyright © 2020 Abdalla Elshikh. All rights reserved.
//

import UIKit

class LoginTextFieldsDelegate: NSObject, UISearchTextFieldDelegate{
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
          //if return is pressed resign first responder to hide keyboard
          textField.resignFirstResponder()
          return true
      }
      func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
          //if text edit is pressed clear text
          textField.text = ""
          return true
      }
      func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
          //if text should change make it first responder
          textField.becomeFirstResponder()
          return true
      }
}
