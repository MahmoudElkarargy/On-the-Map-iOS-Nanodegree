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
        //get locations
        self.refreshData()
        //pull to refresh
        self.refreshControl?.attributedTitle = NSAttributedString(string: "Pull to refresh")
        self.refreshControl?.addTarget(self, action: #selector (refreshData), for: .valueChanged)
     }

    @objc func refreshData(){
        //refresh data in table
        User.getStudentsLocations(completionHandler: displayLocations(data:error:))
    }
    
    @objc func logoutIsPressed(){
        User.logout(completionHandler: {
            (success, error) in
            if success{
                self.tabBarController?.navigationController?.popViewController(animated: true)
            }else{
                self.showAlert(title: "Error", message: "Couldn't Logout")
            }
        })
    }
    
    func displayLocations(data: StudentsLocations?, error: Error?){
        if let data = data{
            StudentsModel.data = data.results
            self.tableView.reloadData()
            self.refreshControl?.endRefreshing()
        }else{
            //error fetching data
            showAlert(title: "Error", message: "Cannot fetch data")
        }
    }
    
    func showAlert(title: String, message: String) {
        let alertVC = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alertVC.addAction(UIAlertAction(title: "Ok", style: .default, handler: nil))
        self.present(alertVC, animated: true)
    }
    
    @objc func addNewPin(){
        performSegue(withIdentifier: "PostNewPin", sender: nil)
    }
}

extension TableViewController{

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return StudentsModel.data.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        //populate table view
        let cell = self.tableView.dequeueReusableCell(withIdentifier: "StudentCell")!
        cell.textLabel?.text = StudentsModel.data[indexPath.row].firstName + " " + StudentsModel.data[indexPath.row].lastName
        cell.detailTextLabel?.text = StudentsModel.data[indexPath.row].mediaURL
        return cell
    }

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        //go to url
        let url = URL(string: StudentsModel.data[indexPath.row].mediaURL)!
        UIApplication.shared.open(url, options: [:], completionHandler: nil)
    }
}
