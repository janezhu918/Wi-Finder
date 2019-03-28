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
    private var savedHotspots = [Hotspot]() {
        didSet {
            self.savedView.savedTableView.reloadData()
        }
    }
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(savedView)
        setupTableView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        savedHotspots = HotspotDataManager.getHotspots()
    }

    
    private func  setupTableView() {
        title = "Saved Hotspots"
        savedView.savedTableView.dataSource = self
        savedView.savedTableView.delegate = self
//        savedView.savedTableView.register(UITableViewCell.CellStyle.subtitle, forCellReuseIdentifier: "SavedCell")
        savedHotspots = HotspotDataManager.getHotspots()
    }
}

extension SavedViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 60
    }
}

extension SavedViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return savedHotspots.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: UITableViewCell = {
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "SavedCell") else {
                return UITableViewCell(style: UITableViewCell.CellStyle.subtitle, reuseIdentifier: "SavedCell")
            }
            return cell
        }()
        let savedHotspot = savedHotspots[indexPath.row]
        cell.textLabel?.text = savedHotspot.locationName
        cell.detailTextLabel?.text = "SSID: " + savedHotspot.ssid
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let detailVC = DetailViewController()
        detailVC.hotspot = savedHotspots[indexPath.row]
        navigationController?.pushViewController(detailVC, animated: true)
    }
    
}
