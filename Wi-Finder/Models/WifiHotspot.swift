//
//  WifiHotspot.swift
//  Wi-Finder
//
//  Created by Jane Zhu on 3/27/19.
//  Copyright © 2019 JaneZhu. All rights reserved.
//

import Foundation

struct WifiHotSpot {
    
    let lat : String
    let long : String
    let address : String
    let ssid : String
    let locationName: String
    let remarks : String
    let zipcode : String
    let city : String
    
    
    init (lat: String, long : String, address : String, ssid : String, locationName: String, remarks : String, zipcode: String, city: String){
        self.lat = lat
        self.long = long
        self.address = address
        self.ssid = ssid
        self.locationName = locationName
        self.remarks = remarks
        self.zipcode = zipcode
        self.city = city
    }
    
}

//  element 12 has indicates if wifi is free
// element 13 shows network provider
// element 14 shows name of locations
// element 15 shows street address
// element 16 latitude
// element 17 longitude
// element 20 access point location (indoor/outdoor)
// element 21 wifi speed and price
