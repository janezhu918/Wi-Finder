//
//  MainTabBar.swift
//  Wi-Finder
//
//  Created by Jane Zhu on 3/27/19.
//  Copyright © 2019 JaneZhu. All rights reserved.
//

import UIKit

class MainTabBar: UITabBarController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let mapVC = MainMapViewController()
        mapVC.tabBarItem = UITabBarItem(title: "Map", image: UIImage(named: "wifi"), tag: 0)
        
        let savedVC = SavedViewController()
        savedVC.tabBarItem = UITabBarItem(title: "Saved", image: UIImage(named: "saved"), tag: 1)
        
        let tabBarLists = [mapVC, savedVC]
        viewControllers = tabBarLists.map(UINavigationController.init)
    }

}
