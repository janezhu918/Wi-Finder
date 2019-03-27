//
//  ViewController.swift
//  Wi-Finder
//
//  Created by Jane Zhu on 3/27/19.
//  Copyright © 2019 JaneZhu. All rights reserved.
//

import UIKit
import MapKit

class MainMapViewController: UIViewController {
let mainview = MainMapView()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(mainview)
    }


}

