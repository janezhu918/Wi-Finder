//
//  ViewController.swift
//  Wi-Finder
//
//  Created by Jane Zhu on 3/27/19.
//  Copyright © 2019 JaneZhu. All rights reserved.
//

import UIKit
import MapKit
import CoreLocation

class MainMapViewController: UIViewController {
    let mainview = MainMapView()
    private let locationManager = CLLocationManager()
    private var searchCoordinates = CLLocationCoordinate2D(latitude: 40.7447, longitude: 73.9485)
    
    
        private var myCurrentArea = MKCoordinateRegion() {
            didSet {
                
            }
        }
    
    

    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(mainview)
        self.view.backgroundColor = #colorLiteral(red: 0.9764705896, green: 0.850980401, blue: 0.5490196347, alpha: 1)
        navigationItem.rightBarButtonItem = UIBarButtonItem(image: #imageLiteral(resourceName: "locate"), style: .plain, target: self, action: #selector(currentLocationButton))
        mainview.mainTableView.delegate = self
        mainview.mainTableView.dataSource = self
        mainview.search.delegate = self
        mainview.mapView.delegate = self
    }
    @objc private func currentLocationButton() {
         mainview.mapView.setCenter(myCurrentArea.center, animated: true)
    }
    
    func checkLocationServices() {
        if CLLocationManager.authorizationStatus() == .authorizedWhenInUse {
            locationManager.desiredAccuracy = kCLLocationAccuracyBest
            locationManager.startUpdatingLocation()
            mainview.mapView.showsUserLocation = true
        } else {
            locationManager.requestWhenInUseAuthorization()
            locationManager.desiredAccuracy = kCLLocationAccuracyBest
            locationManager.startUpdatingLocation()
            mainview.mapView.showsUserLocation = true
        }
    }
}

extension MainMapViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 5
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
        return cell
    }
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return "WiFi Hotspots in this area"
    }
}

extension MainMapViewController: CLLocationManagerDelegate {
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        if status == .authorizedWhenInUse {
            searchCoordinates = myCurrentArea.center
        }
        let currentArea = MKCoordinateRegion(center: searchCoordinates, latitudinalMeters: 500, longitudinalMeters: 500)
        mainview.mapView.setRegion(currentArea, animated: true)
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        myCurrentArea = MKCoordinateRegion()
        if let currentLocation = locations.last {
            myCurrentArea = MKCoordinateRegion(center: currentLocation.coordinate, latitudinalMeters: 500, longitudinalMeters: 500)
        } else {
            myCurrentArea = MKCoordinateRegion(center: searchCoordinates, latitudinalMeters: 500, longitudinalMeters: 500)
        }
    }
}

extension MainMapViewController: MKMapViewDelegate {
    
}

extension MainMapViewController: UISearchBarDelegate {
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchBar.resignFirstResponder()
    }
}
