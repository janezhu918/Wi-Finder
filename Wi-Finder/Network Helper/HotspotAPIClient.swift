//
//  HotspotAPIClient.swift
//  Wi-Finder
//
//  Created by Jane Zhu on 3/27/19.
//  Copyright © 2019 JaneZhu. All rights reserved.
//

import Foundation

final class HotspotAPIClient {
    
    static func searchWifiSpot(completionHandler: @escaping (AppError?, [Hotspot]?) -> Void) {
        let endpointURLString = "https://data.cityofnewyork.us/api/views/varh-9tsp/rows.json?accessType=DOWNLOAD"
        guard let url = URL(string: endpointURLString) else {
            completionHandler(AppError.badURL(endpointURLString), nil)
            return
        }
        let request = URLRequest(url: url)
        URLSession.shared.dataTask(with: request) { (data, response, error) in
            if let error = error {
                completionHandler(AppError.networkError(error), nil)
            }
            guard let httpResponse = response as? HTTPURLResponse, (200...299).contains(httpResponse.statusCode) else { let statusCode = (response as? HTTPURLResponse)?.statusCode ?? -999
                completionHandler(AppError.badStatusCode("\(statusCode)"), nil)
                return
            }
            if let data = data {
                do {
                    let jsonResponse = try JSONSerialization.jsonObject(with: data, options: [])
                    guard let wifiDictionary = jsonResponse as? [String : Any] else {print("Top Level Failed"); return }
                    guard let wifiMatrix = wifiDictionary["data"] as? [[Any?]] else {print("Matrix Decode Failure"); return }
                    var populatingArray = [Hotspot]()
                    for array in wifiMatrix {
                        let lat = array[15] as? String ?? ""
                        let long = array[16] as? String ?? ""
                        let address = array[14] as? String ?? ""
                        let ssid = array[22] as? String ?? ""
                        let locationName = array[13] as? String ?? ""
                        let remarks = array[20] as? String ?? ""
                        let zipcode = array[30] as? String ?? ""
                        let city = array[21] as? String ?? ""
                        populatingArray.append(Hotspot.init(lat: lat, long:long, address: address, ssid: ssid, locationName: locationName, remarks: remarks, zipcode: zipcode, city: city ))
                    }
                    completionHandler(nil,populatingArray)
                } catch {
                    completionHandler(AppError.jsonDecodingError(error), nil)
                }
            }
            }.resume()
        
    }
}

