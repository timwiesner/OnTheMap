//
//  MapTableViewController.swift
//  OnTheMap
//
//  Created by Tim Wiesner on 3/20/19.
//  Copyright © 2019 Tim Wiesner. All rights reserved.
//

import UIKit

class MapTableViewController: UITableViewController {
    
    @IBOutlet var mapTableView: UITableView!
    
//    var students = [StudentLocation]()

    //    MARK: Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        _ = ParseClient.getStudentLocation() { students, error in
            Common.shared.studentLocation = students
        }
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        tableView.reloadData()
//        DispatchQueue.main.async {
//            self.tableView.reloadData()
//        }
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        print(students.count)
//        return students.count
        return Common.shared.studentLocation.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "mapTableViewCell", for: indexPath)
//        let student = students[(indexPath as NSIndexPath).row]
//        let student = students[indexPath.row]
//        cell.textLabel?.text = "\(student.firstName)"
//        cell.textLabel?.text = "\(student.firstName + student.lastName) \(student.mediaURL)"
//        cell.nameText?.text = "\(student.firstName + student.lastName)"
//        cell.urlText?.text = "\(student.mediaURL)"
//        cell.pinIcon!.image = UIImage(named: "icon_pin")
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let studentDetailController = storyboard!.instantiateViewController(withIdentifier: "StudentDetailViewController") as! StudentDetailViewController
//        studentDetailController.student = students[(indexPath as NSIndexPath).row]
        navigationController!.pushViewController(studentDetailController, animated: true)
        
    }
}




