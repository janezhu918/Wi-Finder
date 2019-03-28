//
//  LaunchViewController.swift
//  Wi-Finder
//
//  Created by Genesis Mosquera on 3/28/19.
//  Copyright © 2019 JaneZhu. All rights reserved.
//

import UIKit

class LaunchViewController: UIViewController {

    let launchView = LaunchView()
    
    
    override func viewWillLayoutSubviews() {
        self.launchView.launchImage.backgroundColor = #colorLiteral(red: 0.9764705896, green: 0.850980401, blue: 0.5490196347, alpha: 1)
        self.launchView.launchImage.clipsToBounds = true
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        super.view.addSubview(launchView)
        self.view.backgroundColor = #colorLiteral(red: 0.9880706668, green: 0.8646354079, blue: 0.5588870645, alpha: 1)
        self.view.isOpaque = true

      
    }
    


}
