//
//  MapView.swift
//  Wi-Finder
//
//  Created by Jane Zhu on 3/27/19.
//  Copyright © 2019 JaneZhu. All rights reserved.
//

import UIKit
import MapKit

class MainMapView: UIView {

    public lazy var search: UISearchBar = {
        let searchBar = UISearchBar()
        searchBar.backgroundColor = UIColor.blue.withAlphaComponent(0.1)
        searchBar.layer.cornerRadius = 10.0
        searchBar.placeholder = "Search for Hotspots"
        return searchBar
        
    }()
    
    public lazy var mapView: MKMapView = {
        let map = MKMapView()
        map.layer.cornerRadius = 5.0
        return map
    }()

    public lazy var mainTableView: UITableView = {
        var mainTV = UITableView()
        mainTV = UITableView(frame: .zero, style: .plain)
        mainTV.backgroundColor = #colorLiteral(red: 0.7233230472, green: 0.9350265861, blue: 0.8718754649, alpha: 1)
        mainTV.sectionIndexColor = #colorLiteral(red: 0.9098039269, green: 0.4784313738, blue: 0.6431372762, alpha: 1)
        mainTV.allowsSelection = false
        return mainTV
    }()
    
    
    override init(frame: CGRect) {
        super.init(frame: UIScreen.main.bounds)
        commonInit()
        // initialize cells for TV here
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    private func commonInit() {
        setConstraints()
    }
    func setConstraints() {
        addSubview(search)
        addSubview(mapView)
        addSubview(mainTableView)
        search.translatesAutoresizingMaskIntoConstraints = false
        mapView.translatesAutoresizingMaskIntoConstraints = false
        mainTableView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            search.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor), search.leadingAnchor.constraint(equalTo: leadingAnchor), search.trailingAnchor.constraint(equalTo: trailingAnchor),
            mapView.topAnchor.constraint(equalTo: search.bottomAnchor, constant: 22), mapView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 33), mapView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -33), mapView.heightAnchor.constraint(equalTo: heightAnchor, multiplier: 0.35),
            mainTableView.topAnchor.constraint(equalTo: mapView.bottomAnchor, constant: 11), mainTableView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16), mainTableView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16), mainTableView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -150)
            ])
    }
    
    
}
