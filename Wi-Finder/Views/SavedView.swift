//
//  SavedView.swift
//  Wi-Finder
//
//  Created by Jane Zhu on 3/27/19.
//  Copyright © 2019 JaneZhu. All rights reserved.
//

import UIKit

class SavedView: UIView {
    lazy var savedTableView: UITableView = {
        let tableView = UITableView()
        tableView.tableFooterView  = UIView()
        return tableView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: UIScreen.main.bounds)
        commonInit()
    }
    
    required init?(coder aDecoder: NSCoder) {
      super.init(coder: aDecoder)
        commonInit()

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
