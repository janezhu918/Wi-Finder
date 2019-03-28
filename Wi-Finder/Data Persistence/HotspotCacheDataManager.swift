//
//  HotspotCacheDataManager.swift
//  Wi-Finder
//
//  Created by Jane Zhu on 3/28/19.
//  Copyright © 2019 JaneZhu. All rights reserved.
//

import Foundation
import MapKit

final class HotspotCacheDataManager {
    private init() {}
    private static let filename = "HotspotCache.plist"
//    private static var hotspots = [Hotspot]()
    
    static func saveToCache(hotspots: [Hotspot]) {
        let path = DataPersistenceManager.filepathToDocumentsDirectory(filename: filename)
        do {
            let data = try PropertyListEncoder().encode(hotspots)
            try data.write(to: path, options: Data.WritingOptions.atomic)
        } catch {
            print(error.localizedDescription)
        }
    }
    
    static func loadFromCache() -> (hotspots: [Hotspot], annotations: [MKPointAnnotation]) {
        var hotspots = [Hotspot]()
        var annotations = [MKPointAnnotation]()
        let path = DataPersistenceManager.filepathToDocumentsDirectory(filename: filename).path
        if FileManager.default.fileExists(atPath: path) {
            if let data = FileManager.default.contents(atPath: path) {
                do {
                    hotspots = try PropertyListDecoder().decode([Hotspot].self, from: data)
                    for hotspot in hotspots {
                        let annotation = MKPointAnnotation()
                        annotation.coordinate = CLLocationCoordinate2D.init(latitude: Double(hotspot.lat) ?? 0.0, longitude: Double(hotspot.long) ?? 0.0)
                        annotations.append(annotation)
                    }
                } catch {
                    print("property list decoding error: \(error)")
                }
            } else {
                print("hotspots data is nil")
            }
        } else  {
            print("\(filename) does not exist.")
        }
        return (hotspots: hotspots, annotations: annotations)
    }
}
