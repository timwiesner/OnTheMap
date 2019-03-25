//
//  MapTableViewController.swift
//  OnTheMap
//
//  Created by Tim Wiesner on 3/20/19.
//  Copyright © 2019 Tim Wiesner. All rights reserved.
//

import UIKit

class MapTableViewController: UITableViewController {
    
    var students: [StudentLocation]!
    
    //    MARK: Lifecycle
    override func viewWillAppear(_ animated: Bool) {
        tableView!.reloadData()
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return students.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "MapTableViewCell", for: indexPath) as! MapTableViewCell
        let student = students[(indexPath as NSIndexPath).row]
        cell.populateCell(student)
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let studentDetailController = storyboard!.instantiateViewController(withIdentifier: "StudentDetailViewController") as! StudentDetailViewController
        studentDetailController.student = students[(indexPath as NSIndexPath).row]
        navigationController!.pushViewController(studentDetailController, animated: true)
        
    }
}




