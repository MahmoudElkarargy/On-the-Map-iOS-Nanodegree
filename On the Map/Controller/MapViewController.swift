//
//  MapViewController.swift
//  On the Map
//
//  Created by Abdalla Elshikh on 4/24/20.
//  Copyright © 2020 Abdalla Elshikh. All rights reserved.
//

import UIKit

class MapViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        configureView()
    }
    
    func configureView(){
        self.tabBarController?.navigationItem.hidesBackButton = true
        self.tabBarController?.navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Logout", style: .plain, target: nil, action: nil)
    }

}
