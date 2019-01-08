//
//  ValidUtil.swift
//  FoodDelivery
//
//  Created by Jon McLean on 8/1/19.
//  Copyright © 2019 Jon McLean Development. All rights reserved.
//

import Foundation

class ValidUtil {
    
    func checkEmailValidity(email: String) -> Bool {
        let emailRegex = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        let test = NSPredicate(format: "SELF MATCHES %@", emailRegex)
        
        return test.evaluate(with: email)
    }
    
}
