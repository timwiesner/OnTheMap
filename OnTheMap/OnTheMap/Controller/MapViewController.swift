//
//  MapViewController.swift
//  OnTheMap
//
//  Created by Tim Wiesner on 3/20/19.
//  Copyright © 2019 Tim Wiesner. All rights reserved.
//

import UIKit

class MapViewController: UIViewController {
    
//    var students = [StudentLocation]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        _ = ParseClient.getStudentLocation() { students, error in
            Common.shared.studentLocation = students
            print(students)
        }
    }
}
