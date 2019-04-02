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
    
    // MARK: Outlets
    @IBOutlet weak var mapView: MKMapView!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
    //    MARK: Actions
    @IBAction func logoutTapped(_ sender: UIBarButtonItem) {
        print("Logout")
        UdacityClient.logout {
        }
        DispatchQueue.main.async {
            self.dismiss(animated: true, completion: nil)
        }
    }
    
    @IBAction func refresh(_ sender: UIBarButtonItem) {
        populateStudents()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        populateStudents()
        mapView.delegate = self
    }
    
    func populateStudents() {
        ParseClient.getStudentLocation() { students, error in
            Common.shared.studentLocation = students
            self.addAnnotations(students: students)
        }
    }
    
    func addAnnotations(students: [StudentLocation]) {
        for student in students {
            let location = MKPointAnnotation()
            let latitude = CLLocationDegrees(student.latitude ?? 0)
            let longitude = CLLocationDegrees(student.longitude ?? 0)
            let coordinate = CLLocationCoordinate2D(latitude: latitude, longitude: longitude)
            location.title = student.studentName
            location.subtitle = student.mediaURL
            location.coordinate = coordinate
            locations.append(location)
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
}


