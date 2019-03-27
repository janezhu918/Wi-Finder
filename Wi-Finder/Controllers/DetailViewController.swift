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
        print("save button pressed")
    }
    
    @objc private func screenshotButtonPressed() {
        print("screenshot button pressed")
    }
    
}
