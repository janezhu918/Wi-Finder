//
//  LaunchView.swift
//  Wi-Finder
//
//  Created by Genesis Mosquera on 3/28/19.
//  Copyright © 2019 JaneZhu. All rights reserved.
//

import UIKit

class LaunchView: UIView {

    public lazy var launchImage: UIImageView = {
        let launchImg = UIImageView()
        launchImg.image = UIImage(named: "wifinder")
        launchImg.contentMode = .scaleAspectFit
        return launchImg
    }()

    override init(frame: CGRect) {
        super.init(frame: UIScreen.main.bounds)
        commonInit()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        commonInit()
    }
    private func commonInit() {
        setConstraints()
    }
    func setConstraints() {
        addSubview(launchImage)
        
        launchImage.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            launchImage.heightAnchor.constraint(equalTo: heightAnchor, multiplier: 1), launchImage.widthAnchor.constraint(equalTo: widthAnchor, multiplier: 1), launchImage.centerXAnchor.constraint(equalTo: self.centerXAnchor), launchImage.centerYAnchor.constraint(equalTo: self.centerYAnchor)
            ])
    }
}
