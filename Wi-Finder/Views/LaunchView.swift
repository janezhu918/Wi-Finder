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
        launchImg.image = UIImage(named: "wifi")
        launchImg.contentMode = .scaleAspectFit
        launchImg.layer.borderColor = #colorLiteral(red: 0.9098039269, green: 0.4784313738, blue: 0.6431372762, alpha: 1)
        launchImg.layer.borderWidth = 4
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
            launchImage.heightAnchor.constraint(equalTo: heightAnchor, multiplier: 0.35), launchImage.widthAnchor.constraint(equalTo: widthAnchor, multiplier: 0.75), launchImage.centerXAnchor.constraint(equalTo: self.centerXAnchor), launchImage.centerYAnchor.constraint(equalTo: self.centerYAnchor)
            ])
    }
}
