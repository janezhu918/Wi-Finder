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
 var gradient: CAGradientLayer!
    public lazy var mapKitView: MKMapView = {
        let mk = MKMapView()
        mk.layer.cornerRadius = 10
     mk.layer.borderColor = #colorLiteral(red: 1, green: 0.6097013354, blue: 0.4944909215, alpha: 1)
        mk.layer.borderWidth = 3
        return mk
    }()
    
    public lazy var infoTextView: UITextView = {
       let tv = UITextView()
        tv.dataDetectorTypes = [.address]
        tv.backgroundColor = .clear
        tv.textAlignment = .center
        tv.isEditable = false
        tv.font = .systemFont(ofSize: 16)
        return tv
    }()
    
    override init(frame: CGRect) {
        super.init(frame: UIScreen.main.bounds)
        setupLoginViewBackground()
        commonInit()
    }

    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    private func setupLoginViewBackground()  {
        gradient = CAGradientLayer()
        gradient.frame = self.bounds
        gradient.colors = [UIColor(displayP3Red: 255/255, green: 140/255, blue: 132/255, alpha: 1).cgColor, UIColor(displayP3Red: 247/255, green: 195/255, blue: 106/255, alpha: 1).cgColor, UIColor(displayP3Red: 255/255, green: 225/255, blue: 137/255, alpha: 1).cgColor]
        layer.addSublayer(gradient)
    }
    
    private func commonInit() {
        backgroundColor = .white
        setConstraints()
    }
    
    func setConstraints() {
        addSubview(mapKitView)
        addSubview(infoTextView)
        
        mapKitView.translatesAutoresizingMaskIntoConstraints = false
        infoTextView.translatesAutoresizingMaskIntoConstraints = false
        
        mapKitView.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: 11).isActive = true
        mapKitView.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor, constant: 11).isActive = true
        mapKitView.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor, constant: -11).isActive = true
        mapKitView.heightAnchor.constraint(equalTo: safeAreaLayoutGuide.heightAnchor, multiplier: 0.4).isActive = true
        
        infoTextView.topAnchor.constraint(equalTo: mapKitView.bottomAnchor, constant: 11).isActive = true
        infoTextView.leadingAnchor.constraint(equalTo: mapKitView.leadingAnchor).isActive = true
        infoTextView.trailingAnchor.constraint(equalTo: mapKitView.trailingAnchor).isActive = true
        infoTextView.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor, constant: -11).isActive = true
//        infoTextView.heightAnchor.constraint(equalTo: mapKitView.heightAnchor).isActive = true
    }
}
