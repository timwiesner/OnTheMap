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
    
    var students = [StudentLocation]()
    var locations = [MKPointAnnotation]()
    
    @IBOutlet weak var mapView: MKMapView!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        mapView.delegate = self
        
//        var locations = [MKPointAnnotation]()
        
        _ = ParseClient.getStudentLocation() { students, error in
            Common.shared.studentLocation = students
        }
        
        for student in students {
            let location = MKPointAnnotation()
            location.title = student.firstName + " " + student.lastName
            location.subtitle = student.mediaURL
            location.coordinate = CLLocationCoordinate2DMake(student.latitude, student.longitude)
            locations.append(location)
            print(location)
        }
        mapView.addAnnotations(locations)
        
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
}

//extension MapViewController {
//    func populateLocations() {
//        var locations = [MKPointAnnotation]()
//        ParseClient.getStudentLocation() { students, error in
//            Common.shared.studentLocation = students
//        }
//        for student in students {
//            let location = MKPointAnnotation()
//            location.title = student.firstName + " " + student.lastName
//            location.subtitle = student.mediaURL
//            location.coordinate = CLLocationCoordinate2DMake(student.latitude, student.longitude)
//            locations.append(location)
//            print("Location: \(location)")
//        }
//        mapView.addAnnotations(locations)
////        print(locations)
//    }
//
////    @objc func reloadData() {
////        self.populateLocations()
////    }
//}

