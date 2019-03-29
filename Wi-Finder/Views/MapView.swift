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
<<<<<<< HEAD
    var gradient: CAGradientLayer!
=======
>>>>>>> 13f8060fbdd08b430bccd1a4b8a132a9c6a4fbc4
    public lazy var search: UISearchBar = {
        let searchBar = UISearchBar()
        searchBar.backgroundColor = UIColor.blue.withAlphaComponent(0.1)
        searchBar.layer.cornerRadius = 10.0
        searchBar.placeholder = "Search for hotspots by zipcode"
        searchBar.barTintColor = #colorLiteral(red: 1, green: 0.8813299537, blue: 0.5384758115, alpha: 1)
        return searchBar
        
    }()
    
    public lazy var mapView: MKMapView = {
        let map = MKMapView()
        map.layer.cornerRadius = 10.0
        map.layer.borderColor = #colorLiteral(red: 1, green: 0.6097013354, blue: 0.4944909215, alpha: 1)
        map.layer.borderWidth = 3 
        return map
    }()

    public lazy var mainTableView: UITableView = {
        var mainTV = UITableView()
        mainTV = UITableView(frame: .zero, style: .plain)
        mainTV.backgroundColor = #colorLiteral(red: 1, green: 0.8813299537, blue: 0.5384758115, alpha: 1)
        mainTV.sectionIndexColor = #colorLiteral(red: 0.7254902124, green: 0.4784313738, blue: 0.09803921729, alpha: 1)
        mainTV.tableFooterView = UIView()
        mainTV.separatorStyle = .none
        return mainTV
    }()
    
    
    override init(frame: CGRect) {
        super.init(frame: UIScreen.main.bounds)
        setUpMainViewBG()
        commonInit()
 
    }
    
    

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    private func setUpMainViewBG() {
        gradient = CAGradientLayer()
        gradient.frame = self.bounds
        gradient.colors = [UIColor(displayP3Red: 255/255, green: 140/255, blue: 132/255, alpha: 1).cgColor, UIColor(displayP3Red: 247/255, green: 195/255, blue: 106/255, alpha: 1).cgColor, UIColor(displayP3Red: 255/255, green: 225/255, blue: 137/255, alpha: 1).cgColor]
        layer.addSublayer(gradient)
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
            mapView.topAnchor.constraint(equalTo: search.bottomAnchor, constant: 5), mapView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 5), mapView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -5), mapView.heightAnchor.constraint(equalTo: heightAnchor, multiplier: 0.4),
            mainTableView.topAnchor.constraint(equalTo: mapView.bottomAnchor, constant: 5), mainTableView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 0), mainTableView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: 0), mainTableView.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor, constant: 0)
            ])
    }
    
    
}
