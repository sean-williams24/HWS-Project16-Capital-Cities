//
//  ViewController.swift
//  Project 16 - Capital Cities
//
//  Created by Sean Williams on 24/10/2019.
//  Copyright © 2019 Sean Williams. All rights reserved.
//

import UIKit
import MapKit

class ViewController: UIViewController, MKMapViewDelegate {
    
    @IBOutlet var mapView: MKMapView!

    var capitalCity: String!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let london = Capital(title: "London", coordinate: CLLocationCoordinate2D(latitude: 51.507222, longitude: -0.1275), info: "Home to the 2012 Summer Olympics.")
        let oslo = Capital(title: "Oslo", coordinate: CLLocationCoordinate2D(latitude: 59.95, longitude: 10.75), info: "Founded over a thousand years ago.")
        let paris = Capital(title: "Paris", coordinate: CLLocationCoordinate2D(latitude: 48.8567, longitude: 2.3508), info: "Often called the City of Light.")
        let rome = Capital(title: "Rome", coordinate: CLLocationCoordinate2D(latitude: 41.9, longitude: 12.5), info: "Has a whole country inside it.")
        let washington = Capital(title: "Washington DC", coordinate: CLLocationCoordinate2D(latitude: 38.895111, longitude: -77.036667), info: "Named after George himself.")
        
        mapView.addAnnotations([london, oslo, paris, rome, washington])
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .action, target: self, action: #selector(changeMap))
    }
    
    @objc func changeMap() {
        let ac = UIAlertController(title: "Map Type", message: nil, preferredStyle: .actionSheet)
        ac.addAction(UIAlertAction(title: "Satellite", style: .default, handler: { (action) in self.mapView.mapType = .satellite }))
        ac.addAction(UIAlertAction(title: "Hybrid", style: .default, handler: { (action) in self.mapView.mapType = .hybrid }))
        ac.addAction(UIAlertAction(title: "Hybrid Flyover", style: .default, handler: { (action) in self.mapView.mapType = .hybridFlyover }))
        ac.addAction(UIAlertAction(title: "Muted", style: .default, handler: { (action) in self.mapView.mapType = .mutedStandard }))
        ac.addAction(UIAlertAction(title: "Satellite Flyover", style: .default, handler: { (action) in self.mapView.mapType = .satelliteFlyover }))
        ac.addAction(UIAlertAction(title: "Standard", style: .default, handler: { (action) in self.mapView.mapType = .standard }))

        present(ac, animated:  true)
        
    }
    
    
    
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        //If the annotation isn't from a capital city, it must return nil so iOS uses a default view.
        guard annotation is Capital else { return nil}
        
        let identifier = "Capital"
        
        //Try to dequeue an annotation view from the map view's pool of unused views.
        var annotationView = mapView.dequeueReusableAnnotationView(withIdentifier: identifier) as? MKPinAnnotationView
        
        if annotationView == nil {
            
            //If it isn't able to find a reusable view, create a new one using MKPinAnnotationView and sets its canShowCallout property to true. This triggers the popup with the city name.
            annotationView = MKPinAnnotationView(annotation: annotation, reuseIdentifier: identifier)
            annotationView?.canShowCallout = true
            annotationView?.pinTintColor = .black
            //Create a new UIButton using the built-in .detailDisclosure type. This is a small blue "i" symbol with a circle around it.
            let btn = UIButton(type: .detailDisclosure)
            annotationView?.rightCalloutAccessoryView = btn
        } else {
            //If it can reuse a view, update that view to use a different annotation.
            annotationView?.annotation = annotation
        }
        return annotationView
    }
    
    func mapView(_ mapView: MKMapView, annotationView view: MKAnnotationView, calloutAccessoryControlTapped control: UIControl) {
        guard let annotation = view.annotation as? Capital else { return }
        
        capitalCity = annotation.title
        
        let ac = UIAlertController(title: annotation.title, message: annotation.info, preferredStyle: .alert)
        ac.addAction(UIAlertAction(title: "OK", style: .default))
        ac.addAction(UIAlertAction(title: "More Info", style: .default, handler: { (action) in
            self.performSegue(withIdentifier: "WebView", sender: self)
        }))
        present(ac, animated: true)
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let vc = segue.destination as! WebViewController
        vc.capitalCity = capitalCity
    }
}

