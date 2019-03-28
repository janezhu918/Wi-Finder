//
//  SavedView.swift
//  Wi-Finder
//
//  Created by Jane Zhu on 3/27/19.
//  Copyright © 2019 JaneZhu. All rights reserved.
//

import UIKit

class SavedView: UIView {
    var gradient: CAGradientLayer!
    lazy var savedTableView: UITableView = {
        let tableView = UITableView()
        tableView.backgroundColor = .clear 
        tableView.tableFooterView  = UIView()
        tableView.separatorStyle = .none 
        return tableView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: UIScreen.main.bounds)
        setUpSaveViewBG()
        commonInit()
    }
    
    required init?(coder aDecoder: NSCoder) {
      super.init(coder: aDecoder)
        commonInit()

    }
    private func setUpSaveViewBG() {
        gradient = CAGradientLayer()
        gradient.frame = self.bounds
        gradient.colors = [UIColor(displayP3Red: 255/255, green: 140/255, blue: 132/255, alpha: 1).cgColor, UIColor(displayP3Red: 247/255, green: 195/255, blue: 106/255, alpha: 1).cgColor, UIColor(displayP3Red: 255/255, green: 225/255, blue: 137/255, alpha: 1).cgColor]
        layer.addSublayer(gradient)
    }
    
    private func  commonInit() {
        tableViewConstrains()
    }

    private func tableViewConstrains() {
        addSubview(savedTableView)
        savedTableView.translatesAutoresizingMaskIntoConstraints = false
        savedTableView.widthAnchor.constraint(equalTo: self.widthAnchor).isActive = true
        savedTableView.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true
        savedTableView.heightAnchor.constraint(equalTo: self.heightAnchor).isActive = true
    }

}
