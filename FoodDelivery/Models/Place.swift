//
//  Place.swift
//  FoodDelivery
//
//  Created by Jon McLean on 8/1/19.
//  Copyright © 2019 Jon McLean Development. All rights reserved.
//

import UIKit

class Place {
    
    var name: String
    var latitude: Double
    var longitude: Double
    var uniqueId: String
    var countryCode: String
    var city: String
    
    required init(name: String, latitude: Double, longitude: Double, uniqueId: String, countryCode: String, city: String) {
        self.name = name
        self.latitude = latitude
        self.longitude = longitude
        self.uniqueId = uniqueId
        self.countryCode = countryCode
        self.city = city
    }
    
}
