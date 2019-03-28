//
//  HotspotCacheDataManager.swift
//  Wi-Finder
//
//  Created by Jane Zhu on 3/28/19.
//  Copyright © 2019 JaneZhu. All rights reserved.
//

import Foundation

final class HotspotCacheDataManager {
    private init() {}
    private static let filename = "HotspotCache.plist"
    private static var hotspots = [Hotspot]()
    
    static func saveToCache() {
        let path = DataPersistenceManager.filepathToDocumentsDirectory(filename: filename)
        do {
            let data = try PropertyListEncoder().encode(hotspots)
            try data.write(to: path, options: Data.WritingOptions.atomic)
        } catch {
            print(error.localizedDescription)
        }
    }
    
    static func loadFromCache() -> [Hotspot] {
        let path = DataPersistenceManager.filepathToDocumentsDirectory(filename: filename).path
        if FileManager.default.fileExists(atPath: path) {
            if let data = FileManager.default.contents(atPath: path) {
                do {
                    hotspots = try PropertyListDecoder().decode([Hotspot].self, from: data)
                } catch {
                    print("property list decoding error: \(error)")
                }
            } else {
                print("hotspots data is nil")
            }
        } else  {
            print("\(filename) does not exist.")
        }
        return hotspots
    }
}
