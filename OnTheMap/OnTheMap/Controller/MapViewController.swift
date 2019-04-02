//
//  MapViewController.swift
//  OnTheMap
//
//  Created by Tim Wiesner on 3/20/19.
//  Copyright © 2019 Tim Wiesner. All rights reserved.
//

import UIKit
import MapKit

class MapViewController: UIViewController, MKMapViewDelegate {
    
    var locations = [MKPointAnnotation]()
    var students = [StudentLocation]()

    @IBOutlet weak var mapView: MKMapView!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        populateStudents()
        mapView.delegate = self
    }
    
    func populateStudents() {
        ParseClient.getStudentLocation(completion: handlePopulateStudents(students: error:))
    }
    
    func handlePopulateStudents(students: [StudentLocation]?, error: Error?) {
        guard let students = students else {
            print(error!)
            return
        }
        Common.shared.studentLocation = students
        addAnnotations(students: students)
    }
    
    func addAnnotations(students: [StudentLocation]) {
        for student in students {
            let location = MKPointAnnotation()
            location.title = student.firstName + " " + student.lastName
            location.subtitle = student.mediaURL
            location.coordinate = CLLocationCoordinate2D(latitude: student.latitude, longitude: student.longitude)
            locations.append(location)
            print(location)
        }
        self.mapView.addAnnotations(locations)
    }
    
    
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        guard annotation is MKPointAnnotation else { return nil }
        
        let identifier = "Annotation"
        var annotationView = mapView.dequeueReusableAnnotationView(withIdentifier: identifier)
        
        if annotationView == nil {
            annotationView = MKPinAnnotationView(annotation: annotation, reuseIdentifier: identifier)
            annotationView!.canShowCallout = true
        } else {
            annotationView!.annotation = annotation
        }
        return annotationView
    }
    
    @IBAction func logoutTapped(_ sender: UIBarButtonItem) {
        print("Logout")
        UdacityClient.logout {
        }
        DispatchQueue.main.async {
            self.dismiss(animated: true, completion: nil)
        }
    }
    
    
    
}



////    @objc func reloadData() {
////        self.populateLocations()
////    }
//}

