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
        detailView.infoTextView.text = "Address:\n\(hotspot.address)\n \(hotspot.city), NY \(hotspot.zipcode)"
        detailView.saveButton.addTarget(self, action: #selector(saveButtonPressed), for: .touchUpInside)
        detailView.screenshotButton.addTarget(self, action: #selector(screenshotButtonPressed), for: .touchUpInside)
    }

    @objc private func saveButtonPressed() {
        if let newHotspot = hotspot {
         HotspotDataManager.addHotspot(hotspot: newHotspot)
            showAlert(title: nil, message: "wifi saved", actionTitle: "OK")
        }
    }
    
    @objc private func screenshotButtonPressed() {
        var screenShotImage: UIImage!
        let layer = UIApplication.shared.keyWindow?.layer
        let scale = UIScreen.main.scale
        UIGraphicsBeginImageContextWithOptions(detailView.mapKitView.frame.size, false, scale)
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
