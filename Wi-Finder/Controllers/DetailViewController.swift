//
//  DetailViewController.swift
//  Wi-Finder
//
//  Created by Jane Zhu on 3/27/19.
//  Copyright © 2019 JaneZhu. All rights reserved.
//

import UIKit
import MapKit
import AudioToolbox

class DetailViewController: UIViewController {
    let detailView = DetailView()
    public var hotspot: Hotspot!
    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(detailView)
        if hotspot.remarks != "" {
            detailView.infoTextView.text = "Name:\n\(hotspot.locationName)\n\nAddress:\n\(hotspot.address)\n \(hotspot.city), NY \(hotspot.zipcode)\n\nSSID:\n\(hotspot.ssid)\n\nRemarks:\n\(hotspot.remarks)"
        } else {
            detailView.infoTextView.text = "Name:\n\(hotspot.locationName)\n\nAddress:\n\(hotspot.address)\n \(hotspot.city), NY \(hotspot.zipcode)\n\nSSID:\n\(hotspot.ssid)"
        }
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "•••", style: .plain, target: self, action: #selector(showActionAlert))
        setupMap()
    }
    
    private func setupMap() {
        detailView.mapKitView.delegate = self
        let regionRadius: CLLocationDistance = 650
        let initialLocation = CLLocation(latitude: Double(hotspot!.lat) ?? 0.0, longitude: Double(hotspot!.long) ?? 0.0)
        let coordinateRegion = MKCoordinateRegion(center: initialLocation.coordinate, latitudinalMeters: regionRadius, longitudinalMeters: regionRadius)
        detailView.mapKitView.setRegion(coordinateRegion, animated: false)
        let annotation = MKPointAnnotation()
        annotation.coordinate = CLLocationCoordinate2D(latitude: initialLocation.coordinate.latitude, longitude: initialLocation.coordinate.longitude)
        annotation.title = hotspot.locationName
        detailView.mapKitView.addAnnotation(annotation)
    }
    
    @objc private func showActionAlert() {
        let alert = UIAlertController(title: "More Options", message: "", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Save Hotspot", style: .default, handler: { (action) in
            self.saveButtonPressed()
        }))
        alert.addAction(UIAlertAction(title: "Take Screenshot", style: .default, handler: { (action) in
            self.screenshotButtonPressed()
        }))
        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        present(alert, animated: true, completion: nil)
    }

    private func saveButtonPressed() {
        if let newHotspot = hotspot {
         HotspotDataManager.addHotspot(hotspot: newHotspot)
            showAlert(title: nil, message: "Hotspot Saved", actionTitle: "OK")
        }
    }
    
    private func screenshotButtonPressed() {
        var screenShotImage: UIImage!
        let layer = UIApplication.shared.keyWindow?.layer
        let scale = UIScreen.main.scale
        UIGraphicsBeginImageContextWithOptions(view.frame.size, false, scale)
        guard let context = UIGraphicsGetCurrentContext() else  { return }
        layer?.render(in: context)
        screenShotImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        if let image = screenShotImage {
            UIImageWriteToSavedPhotosAlbum(image, nil, nil, nil)
            AudioServicesPlaySystemSound(1108);
            showAlert(title: nil, message: "Image Saved", actionTitle: "OK")
        }
    }
    
}

extension DetailViewController: MKMapViewDelegate {
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        let annotationView = MKMarkerAnnotationView(annotation: annotation, reuseIdentifier: "pin")
        annotationView.markerTintColor = UIColor.init(displayP3Red: 247/255, green: 195/255, blue: 106/255, alpha: 1)
        annotationView.glyphImage =  UIImage(named: "wifi")
        return annotationView
    }
}
