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
            self.mainview.mapView.reloadInputViews()
        }
    }
    
    private var hotspots = [Hotspot]()
    private var annotations = [MKPointAnnotation]()
    private var searchAnnotations = [MKPointAnnotation]() {
        didSet {
            DispatchQueue.main.async {
                self.mainview.mapView.reloadInputViews()
                self.mainview.mapView.addAnnotations(self.searchAnnotations)
                guard !self.searchAnnotations.isEmpty else {
                    return
                }
                let region = MKCoordinateRegion(center: self.searchAnnotations.first!.coordinate, latitudinalMeters: 2400, longitudinalMeters: 2400)
                self.mainview.mapView.setRegion(region, animated: false)
            }
        }
    }
    private var searchHotspots = [Hotspot]() {
        didSet {
            DispatchQueue.main.async {
                self.mainview.mainTableView.reloadData()
            }
        }
    }
    
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
        locationManager.delegate = self
        getHotspots()
        checkLocationServices()
    }
    
    private func getHotspots() {
        HotspotAPIClient.searchWifiSpot { (error, hotspots, annotations) in
            if let error = error {
                print(error)
            } else if let hotspots = hotspots {
                self.hotspots = hotspots
                self.searchHotspots = hotspots
                DispatchQueue.main.async {
                    self.mainview.mainTableView.reloadData()
                }
                if let annotations = annotations {
                    self.annotations = annotations
                    self.searchAnnotations = annotations
                    self.mainview.mapView.addAnnotations(self.searchAnnotations)
                    let region = MKCoordinateRegion(center: annotations.first!.coordinate, latitudinalMeters: 2400, longitudinalMeters: 2400)
                    DispatchQueue.main.async {
                        self.mainview.mapView.setRegion(region, animated: false)
                    }
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
        let myLocation = CLLocation(latitude: myCurrentArea.center.latitude, longitude: myCurrentArea.center.longitude)
        updateResultsWithinRadiusOfCurrentLocation(myLocation: myLocation)
        
    }
    
    
    func updateResultsWithinRadiusOfCurrentLocation(myLocation : CLLocation) {
        for hotspot in hotspots {
            if myLocation.distance(from: CLLocation(latitude: Double(hotspot.lat) ?? 0.0, longitude: Double(hotspot.long) ?? 0.0)) < 200 {
                searchHotspots.append(hotspot)
            }
        }
    }
    
}

extension MainMapViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return searchHotspots.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
        let hotspotToSet = searchHotspots[indexPath.row]
        cell.textLabel?.text = hotspotToSet.locationName
        cell.detailTextLabel?.text = hotspotToSet.ssid
        cell.textLabel?.font = UIFont.boldSystemFont(ofSize: 17)
        cell.textLabel?.shadowColor = #colorLiteral(red: 0.9705753922, green: 0.7638127208, blue: 0.4173654318, alpha: 1)
        cell.textLabel?.shadowOffset = CGSize(width: 0, height: 2)
        cell.textLabel?.textColor = .black
        cell.selectionStyle = .none
        cell.backgroundColor = #colorLiteral(red: 1, green: 0.8813299537, blue: 0.5384758115, alpha: 1)
        return cell
    }
    
    
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return "WiFi Hotspots in this area"
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let detailVC = DetailViewController()
        detailVC.hotspot = searchHotspots[indexPath.row]
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
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        let annotationView = MKMarkerAnnotationView(annotation: annotation, reuseIdentifier: "pin")
        annotationView.markerTintColor = UIColor.init(displayP3Red: 247/255, green: 195/255, blue: 106/255, alpha: 1)
        annotationView.glyphImage =  UIImage(named: "wifi")
        return annotationView
    }
    
    func mapView(_ mapView: MKMapView, didSelect view: MKAnnotationView) {
        let detailVC = DetailViewController()
        guard let annotation = view.annotation else {
            return
        }
        let index = hotspots.index{ Double($0.lat) == annotation.coordinate.latitude && Double($0.long) == annotation.coordinate.longitude}
        if let SelectedHotspot = index {
            let hotspot = hotspots[SelectedHotspot]
            detailVC.hotspot = hotspot
            navigationController?.pushViewController(detailVC, animated: true)
        }
        
    }
}

extension MainMapViewController: UISearchBarDelegate {
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchBar.resignFirstResponder()
        mainview.mapView.removeAnnotations(searchAnnotations)
        self.searchHotspots.removeAll()
        self.searchAnnotations.removeAll()
        
        guard let text = searchBar.text, let number = Int(text) else {
            showAlert(title: nil, message: "enter valid zipcode", actionTitle: "OK")
            return
        }
        searchHotspots = hotspots.filter{$0.zipcode == String(number)}
        searchAnnotations = searchHotspots.map {
            let annotation = MKPointAnnotation()
            annotation.coordinate = CLLocationCoordinate2D(latitude: Double($0.lat) ?? 0.0, longitude: Double($0.long) ?? 0.0)
            return annotation
        }
    }
    
}

