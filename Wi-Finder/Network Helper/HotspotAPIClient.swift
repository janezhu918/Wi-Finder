//
//  HotspotAPIClient.swift
//  Wi-Finder
//
//  Created by Jane Zhu on 3/27/19.
//  Copyright © 2019 JaneZhu. All rights reserved.
//

import Foundation

final class HotspotAPIClient {
    private var endpointURLString = "https://data.cityofnewyork.us/api/views/varh-9tsp/rows.json?accessType=DOWNLOAD"
    
    static func searchWifiSpot(endPointURLString: String, completionHandler: @escaping (AppError?, [[Any?]]?) -> Void) {
        guard let url = URL(string: endPointURLString) else {
            completionHandler(AppError.badURL(endPointURLString), nil)
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
                    var populatingArray = [WifiHotSpot]()
                    for array in wifiMatrix {
                       
                        let lat = array[16] as? String ?? ""
                        let long = array[17] as? String ?? ""
                        let address = array[15] as? String ?? ""
                        let ssid = array[23] as? String ?? ""
                        let locationName = array[14] as? String ?? ""
                        let remarks = array[21] as? String ?? ""
                        let zipcode = array[31] as? String ?? ""
                        let city = array[22] as? String ?? ""
                        populatingArray.append(WifiHotSpot.init(lat: lat, long:long, address: address, ssid: ssid, locationName: locationName, remarks: remarks, zipcode: zipcode, city: city ))
                    }
                    print(populatingArray)
                    completionHandler(nil,nil)
                } catch {
                    completionHandler(AppError.jsonDecodingError(error), nil)
                }
            }
            }.resume()
        
    }
}

