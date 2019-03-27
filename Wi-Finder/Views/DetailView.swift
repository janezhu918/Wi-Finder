//
//  DetailView.swift
//  Wi-Finder
//
//  Created by Jane Zhu on 3/27/19.
//  Copyright © 2019 JaneZhu. All rights reserved.
//

import UIKit
import MapKit

class DetailView: UIView {

    public lazy var mapKitView: MKMapView = {
        let mk = MKMapView()
        return mk
    }()
    
    public lazy var infoTextView: UITextView = {
       let tv = UITextView()
        tv.dataDetectorTypes = [.address]
        tv.backgroundColor = .white
        tv.textAlignment = .center
        tv.isEditable = false
        tv.font = .systemFont(ofSize: 16)
        return tv
    }()
    
    public lazy var saveButton: UIButton = {
        let button = UIButton()
        button.backgroundColor = .white
        button.setImage(UIImage(named: "saveButton"), for: .normal)
        return button
    }()
    
    public lazy var screenshotButton: UIButton = {
        let button = UIButton()
        button.backgroundColor = .white
        button.setImage(UIImage(named: "screenshot"), for: .normal)
        return button
    }()
    
    override init(frame: CGRect) {
        super.init(frame: UIScreen.main.bounds)
        commonInit()
    }

    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    private func commonInit() {
        backgroundColor = .white
        setConstraints()
    }
    
    func setConstraints() {
        addSubview(mapKitView)
        addSubview(infoTextView)
        addSubview(saveButton)
        addSubview(screenshotButton)
        
        mapKitView.translatesAutoresizingMaskIntoConstraints = false
        infoTextView.translatesAutoresizingMaskIntoConstraints = false
        saveButton.translatesAutoresizingMaskIntoConstraints = false
        screenshotButton.translatesAutoresizingMaskIntoConstraints = false
        
        mapKitView.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: 11).isActive = true
        mapKitView.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor, constant: 11).isActive = true
        mapKitView.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor, constant: -11).isActive = true
        mapKitView.heightAnchor.constraint(equalTo: safeAreaLayoutGuide.heightAnchor, multiplier: 0.4).isActive = true
        
        infoTextView.topAnchor.constraint(equalTo: mapKitView.bottomAnchor, constant: 11).isActive = true
        infoTextView.leadingAnchor.constraint(equalTo: mapKitView.leadingAnchor).isActive = true
        infoTextView.trailingAnchor.constraint(equalTo: mapKitView.trailingAnchor).isActive = true
        infoTextView.heightAnchor.constraint(equalTo: mapKitView.heightAnchor).isActive = true
        
        saveButton.heightAnchor.constraint(equalToConstant: 50).isActive = true
        saveButton.widthAnchor.constraint(equalTo: saveButton.heightAnchor).isActive = true
        saveButton.leadingAnchor.constraint(equalTo: mapKitView.leadingAnchor).isActive = true
        saveButton.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor, constant: -11).isActive = true
        
        screenshotButton.heightAnchor.constraint(equalToConstant: 50).isActive = true
        screenshotButton.widthAnchor.constraint(equalTo: screenshotButton.heightAnchor).isActive = true
        screenshotButton.trailingAnchor.constraint(equalTo: mapKitView.trailingAnchor).isActive = true
        screenshotButton.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor, constant: -11).isActive = true
    }
}
