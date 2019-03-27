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
    private var searchCoordinates = CLLocationCoordinate2D(latitude: 40.7447, longitude: -73.9485)
    private var myCurrentArea = MKCoordinateRegion() {
            didSet {
                
            }
        }
    
    private var hotspots = [Hotspot]()
    private var annotations = [MKPointAnnotation]()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(mainview)
        title = "WiFi Hotspots"
        self.view.backgroundColor = #colorLiteral(red: 0.9764705896, green: 0.850980401, blue: 0.5490196347, alpha: 1)
        navigationItem.rightBarButtonItem = UIBarButtonItem(image: #imageLiteral(resourceName: "locate"), style: .plain, target: self, action: #selector(currentLocationButton))
        mainview.mainTableView.delegate = self
        mainview.mainTableView.dataSource = self
        mainview.search.delegate = self
        mainview.mapView.delegate = self
        getHotspots()
        checkLocationServices()
    }
    
    private func getHotspots() {
        HotspotAPIClient.searchWifiSpot { (error, hotspots, annotations) in
            if let error = error {
                print(error)
            } else if let hotspots = hotspots {
                self.hotspots = hotspots
                DispatchQueue.main.async {
                    self.mainview.mainTableView.reloadData()
                }
                if let annotations = annotations {
                    self.annotations = annotations
                    self.mainview.mapView.addAnnotations(annotations)
                    let region = MKCoordinateRegion(center: annotations.first!.coordinate, latitudinalMeters: 2400, longitudinalMeters: 2400)
                    DispatchQueue.main.async {
                                            self.mainview.mapView.setRegion(region, animated: false)
                    }
//                    self.mainview.mapView.setRegion(annotations, animated: <#T##Bool#>)
                }
            }
        }
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
    
    @objc private func currentLocationButton() {
         mainview.mapView.setCenter(myCurrentArea.center, animated: true)
    }

}

extension MainMapViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return hotspots.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
        let hotspotToSet = hotspots[indexPath.row]
        cell.textLabel?.text = hotspotToSet.locationName
        cell.detailTextLabel?.text = hotspotToSet.ssid
        return cell
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return "WiFi Hotspots in this area"
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let detailVC = DetailViewController()
        detailVC.hotspot = hotspots[indexPath.row]
        navigationController?.pushViewController(detailVC, animated: true)
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
