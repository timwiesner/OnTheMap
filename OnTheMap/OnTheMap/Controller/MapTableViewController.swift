//
//  MapTableViewController.swift
//  OnTheMap
//
//  Created by Tim Wiesner on 3/20/19.
//  Copyright © 2019 Tim Wiesner. All rights reserved.
//

import UIKit

class MapTableViewController: UITableViewController {
    
    var students = [StudentLocation]()
    
    //    MARK: Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        students = Common.shared.studentLocation
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return students.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "mapTableViewCell", for: indexPath)
        let student = students[indexPath.row]
//        cell.textLabel?.text = "\(student.firstName + student.lastName)"
        cell.textLabel?.text = student.firstName + " " + student.lastName
        cell.detailTextLabel?.text = student.mediaURL
        cell.imageView?.image = UIImage(named: "icon_pin")

        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let studentDetailController = storyboard!.instantiateViewController(withIdentifier: "StudentDetailViewController") as! StudentDetailViewController
//        studentDetailController.student = students[(indexPath as NSIndexPath).row]
        navigationController!.pushViewController(studentDetailController, animated: true)
        
    }
}

