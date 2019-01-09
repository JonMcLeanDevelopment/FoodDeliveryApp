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
        let params: Parameters = ["phone": phone]
        
        Alamofire.request(url, method: .post, parameters: params, encoding: URLEncoding.default, headers: nil).responseString { (response) in
            if let jsonString = response.result.value {
                completionHandler(jsonString)
            }
        }
    }
    
    func registerUser(phoneNumber: String, fullName: String, email: String, password: String, completionHandler: @escaping NetworkResponse) {
        let url = baseUrl + "auth/user/register"
        let params: Parameters = ["phone" : phoneNumber, "fullName": fullName, "email": email, "password": password]
        Alamofire.request(url, method: .post, parameters: params, encoding: URLEncoding.default, headers: nil).responseString { (response) in
            if let jsonString = response.result.value {
                completionHandler(jsonString)
            }
        }
    }
    
    func loginUser(phoneNumber: String, password: String, completionHandler: @escaping NetworkResponse) {
        let url = baseUrl + "auth/user/login"
        let params: Parameters = ["phone": phoneNumber, "password": password]
        Alamofire.request(url, method: .post, parameters: params, encoding: URLEncoding.default, headers: nil).responseString { (response) in
            if let json = response.result.value {
                completionHandler(json)
            }
        }
    }
    
    func getPlaces(latitude: Double, longitude: Double, countryCode: String, city: String, completionHandler: @escaping NetworkResponse) {
        let url = baseUrl + "places/retrieve"
        print(url)
        let params: Parameters = ["latitude": latitude, "longitude": longitude, "countryCode": countryCode, "city": city]
        Alamofire.request(url, method: .post, parameters: params, encoding: URLEncoding.default, headers: nil).responseString { (response) in
            if let json = response.result.value {
                completionHandler(json)
            }
        }
    }
    
}
