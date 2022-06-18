//
//  RequestExpertViewController.swift
//  insurance
//
//  Created by MR.CHEMALY on 9/10/18.
//  Copyright © 2018 app-loads. All rights reserved.
//

import UIKit
import GoogleMaps

class RequestExpertViewController: BaseViewController, GMSMapViewDelegate, CLLocationManagerDelegate {

    @IBOutlet weak var buttonRequest: UIButton!
    @IBOutlet weak var mapView: GMSMapView!
    
    var locationManager: CLLocationManager!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.initializeViews()
        self.initializeLocationManager()
        self.setupMapView()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func initializeViews() {
        self.buttonRequest.layer.cornerRadius = Dimensions.cornerRadiusNormal
        
        if let toolbarView = self.overlayView as? ToolbarView {
            toolbarView.labelTitle.text = "REQUEST EXPERT"
            toolbarView.dashboardView.removeFromSuperview()
            toolbarView.closeView.removeFromSuperview()
        }
    }
    
    func initializeLocationManager() {
        self.locationManager = CLLocationManager()
        self.locationManager.delegate = self
        
        if #available(iOS 8.0, *) {
            if CLLocationManager.authorizationStatus() == .notDetermined {
                self.locationManager.requestWhenInUseAuthorization()
            }
        }
        
        self.locationManager.desiredAccuracy = kCLLocationAccuracyBest
        self.locationManager.distanceFilter = kCLDistanceFilterNone
        self.locationManager.startUpdatingLocation()
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if let location = locations.last {            
            let camera = GMSCameraPosition.camera(withLatitude: location.coordinate.latitude, longitude: location.coordinate.longitude, zoom: 8.0)
            self.mapView?.animate(to: camera)
            
            self.locationManager.stopUpdatingLocation()
        }
    }
    
    func setupMapView() {
        self.mapView.delegate = self
        self.mapView.mapType = .normal
        self.mapView.isMyLocationEnabled = true
        
//        var index = 0
//        for obj in DatabaseObjects.objs {
//            // Creates a marker in the center of the map.
//            let marker = GMSMarker()
//
//            if let location = obj.location {
//                let coordinates = location.split{$0 == ","}.map(String.init)
//                if let latitude = coordinates.first, let longitude = coordinates.last {
//                    let latitude = Double(latitude)
//                    let longitude = Double(longitude)
//                    marker.position = CLLocationCoordinate2D(latitude: latitude!, longitude: longitude!)
//                }
//            }
//
//            let view = Bundle.main.loadNibNamed("MapPinSmallView", owner: self.view, options: nil)
//            if let iconView = view?.first as? MapPinSmallView {
//                iconView.labelTitle.text = parking.title
//                marker.iconView = iconView
//            }
//
//            marker.title = String(describing: index)
//            marker.map = self.mapView
//
//            index += 1
//        }
    }
    
    func mapView(_ mapView: GMSMapView, markerInfoWindow marker: GMSMarker) -> UIView? {
        return UIView()
    }
    
    @IBAction func buttonRequestTapped(_ sender: Any) {
        self.redirectToVC(storyboardId: StoryboardIds.RequestExpertDetailsViewController, type: .present)
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
