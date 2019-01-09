//
//  LocationHelper.swift
//  FoodDelivery
//
//  Created by Jon McLean on 9/1/19.
//  Copyright © 2019 Jon McLean Development. All rights reserved.
//

import Foundation
import CoreLocation


class LocationHelper {
    
    let r: Double = 6731
    
    func distance(lat1: Double, long1: Double, lat2: Double, long2: Double) -> Double{
        
        let dLat = lat1 - lat2
        let dLong = long1 - long2
        
        return ((r * Double.pi) / 180) * sqrt((dLat * dLat) + (dLong * dLong))
    }
    
}
