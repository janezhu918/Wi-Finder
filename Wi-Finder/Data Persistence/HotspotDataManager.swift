//
//  HotspotDataManager.swift
//  Wi-Finder
//
//  Created by Jane Zhu on 3/27/19.
//  Copyright © 2019 JaneZhu. All rights reserved.
//

import Foundation


final class HotspotDataManager {
    private init() {}
   private static let hotspotFilename = "Hotspot.plist"
    private static var hotspots = [Hotspot]()
    
    static func saveHotspot() {
        let path = DataPersistenceManager.filepathToDocumentsDirectory(filename: hotspotFilename)
        do {
            let data = try PropertyListEncoder().encode(hotspots)
            try data.write(to: path, options: Data.WritingOptions.atomic)
        } catch {
         print(error.localizedDescription)
        }

    }
    
    static func getHotspots() -> [Hotspot] {
        let path = DataPersistenceManager.filepathToDocumentsDirectory(filename: hotspotFilename).path
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
            print("\(hotspotFilename) does not exist.")
        }
        //sort hotspots
        return hotspots
    }
    
    
    static func addHotspot(hotspot: Hotspot) {
        hotspots.append(hotspot)
        saveHotspot()
    }

    static func deleteHotspot(atIndex: Int) {
        hotspots.remove(at: atIndex)
       saveHotspot()
    }
    
    
    
    
}
