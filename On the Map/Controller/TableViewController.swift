//
//  TableViewController.swift
//  On the Map
//
//  Created by Abdalla Elshikh on 4/24/20.
//  Copyright © 2020 Abdalla Elshikh. All rights reserved.
//

import UIKit

class TableViewController: UITableViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        configureView()
    }
    
    func configureView(){
         self.tabBarController?.navigationItem.hidesBackButton = true
         self.tabBarController?.navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Logout", style: .plain, target: self, action: #selector(logoutIsPressed))
         self.tabBarController?.navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(named: "icon_addpin"), style: .plain, target: self, action: #selector(addNewPin))
     }

    
    @objc func logoutIsPressed(){
        User.logout(completionHandler: {
            (success, error) in
            if success{
                self.tabBarController?.navigationController?.popViewController(animated: true)
            }else{
                print("couldn't logout")
            }
        })
    }
    
    @objc func addNewPin(){
        print("add new pin")
    }
}
