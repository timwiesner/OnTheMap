//
//  MapTableViewController.swift
//  OnTheMap
//
//  Created by Tim Wiesner on 3/20/19.
//  Copyright © 2019 Tim Wiesner. All rights reserved.
//

import UIKit
import SafariServices

class MapTableViewController: UITableViewController, SFSafariViewControllerDelegate {
    
    var students = [StudentLocation]()
    
    //    MARK: Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        students = Common.shared.studentLocation
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
        cell.textLabel?.text = student.firstName + " " + student.lastName
        cell.detailTextLabel?.text = student.mediaURL
        cell.imageView?.image = UIImage(named: "icon_pin")
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let student = students[indexPath.row]
        let urlString = student.mediaURL
        
        if let url = URL(string: urlString) {
            UIApplication.shared.open(url, options: [:], completionHandler: nil)
//            UIApplication.shared.canOpenURL(url)
        } else {
            let alertVC = UIAlertController(title: "Invalid URL", message: "Invalid URL", preferredStyle: .alert)
            alertVC.addAction(UIAlertAction(title: "Ok", style: .default, handler: nil))
            show(alertVC, sender: nil)
        }
    }
}

