//
//  MapViewController.swift
//  Hacked Airline
//
//  Created by Dr. Drake 007 on 28/09/2019.
//  Copyright © 2019 Dr. Drake 007. All rights reserved.
//

import UIKit
import MapKit
import Polyline
import CoreLocation

class MapViewController: UIViewController, MKMapViewDelegate {

    @IBOutlet weak var navBar: UINavigationBar!
    @IBOutlet weak var mapV: MKMapView!
    @IBOutlet weak var fromAirport: UILabel!
    @IBOutlet weak var fromTym: UILabel!
    @IBOutlet weak var toAirport: UILabel!
    @IBOutlet weak var toTym: UILabel!
    @IBOutlet weak var termNum: UILabel!
    let LAX = CLLocation(latitude: 33.9424955, longitude: -118.4080684)
    let JFK = CLLocation(latitude: 40.6397511, longitude: -73.7789256)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        mapV.delegate = self
        
        let span:MKCoordinateSpan = MKCoordinateSpan(latitudeDelta: 90, longitudeDelta: 90)
        let span1:MKCoordinateSpan = MKCoordinateSpan(latitudeDelta: 90, longitudeDelta: 90)
        
        let region:MKCoordinateRegion = MKCoordinateRegion(center: MapCordinates.LAX.coordinate, span: span)
        let region1:MKCoordinateRegion = MKCoordinateRegion(center: MapCordinates.JFK.coordinate, span: span1)
        
        mapV.setRegion(region1, animated: true)
        mapV.setRegion(region, animated: true)
        
        let myAn1 = MKPointAnnotation(__coordinate: MapCordinates.LAX.coordinate, title: fromAirport.text!, subtitle: "Flying from");
        let myAn2 = MKPointAnnotation(__coordinate: MapCordinates.JFK.coordinate, title: toAirport.text!, subtitle: "Flying to");
        var coordinates = [MapCordinates.LAX.coordinate, MapCordinates.JFK.coordinate]
        let geodesicPolyline = MKGeodesicPolyline(coordinates: &coordinates, count: 2)
        
        mapV.addAnnotation(myAn2)
        mapV.addAnnotation(myAn1)
        mapV.addOverlay(geodesicPolyline)
        
    }

    
    func mapView(_ mapView: MKMapView, rendererFor overlay: MKOverlay) -> MKOverlayRenderer {
        guard let polyline = overlay as? MKPolyline else {
            return MKOverlayRenderer()
        }
        
        let renderer = MKPolylineRenderer(polyline: polyline)
        renderer.lineWidth = 3.0
        renderer.alpha = 0.5
        renderer.strokeColor = UIColor.black
        
        return renderer
    }
    
    @IBAction func shareBtn(_ sender: Any) {
    }
    
    @IBAction func backBtn(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
}
