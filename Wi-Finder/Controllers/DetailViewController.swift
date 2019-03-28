//
//  DetailViewController.swift
//  Wi-Finder
//
//  Created by Jane Zhu on 3/27/19.
//  Copyright © 2019 JaneZhu. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController {
    
    let detailView = DetailView()
    
    public var hotspot: Hotspot!

    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(detailView)
        detailView.infoTextView.text = "Address:\n\(hotspot.address)\n \(hotspot.city), NY \(hotspot.zipcode)\n\nSSID:\n\(hotspot.ssid)\n\nRemarks:\n\(hotspot.remarks)"
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "•••", style: .plain, target: self, action: #selector(showActionSheet))
    }
    
    @objc private func showActionSheet() {
        let alert = UIAlertController(title: "More Options", message: "", preferredStyle: .actionSheet)
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
            showAlert(title: nil, message: "wifi saved", actionTitle: "OK")
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
            showAlert(title: nil, message: "image saved", actionTitle: "ok")
        }
    }
    
}
