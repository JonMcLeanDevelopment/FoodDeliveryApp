//
//  NetworkManager.swift
//  FoodDelivery
//
//  Created by Jon McLean on 7/1/19.
//  Copyright © 2019 Jon McLean Development. All rights reserved.
//

import Foundation
import Alamofire

class NetworkManager {
    
    typealias NetworkResponse = (_ json: Any) -> Void
    
    let baseUrl = "http://192.168.1.74:8080/food_delivery/"
    
    func checkPhoneNumber(phone: String, completionHandler: @escaping NetworkResponse) {
        let url = baseUrl + "auth/user/check/phone"
        print("URL: \(url)")
        let params: Parameters = ["phone": phone]
        
        Alamofire.request(url, method: .post, parameters: params, encoding: URLEncoding.default, headers: nil).responseString { (response) in
            if let jsonString = response.result.value {
                completionHandler(jsonString)
            }
        }
    }
    
}
