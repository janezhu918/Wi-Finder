//
//  SavedViewController.swift
//  Wi-Finder
//
//  Created by Jane Zhu on 3/27/19.
//  Copyright © 2019 JaneZhu. All rights reserved.
//

import UIKit

class SavedViewController: UIViewController {
let savedView = SavedView()
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(savedView)
        setupTableView()
    }

    
    private func  setupTableView() {
        title = "Saved Hotspots"
        savedView.savedTableView.dataSource = self
        savedView.savedTableView.delegate = self
    }
}

extension SavedViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 60
    }
}

extension SavedViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 4
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
       let cell = tableView.dequeueReusableCell(withIdentifier: "SavedCell", for: indexPath)
        cell.textLabel?.text = indexPath.row.description
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let detailVC = DetailViewController()
        navigationController?.pushViewController(detailVC, animated: true)
    }
    
}
