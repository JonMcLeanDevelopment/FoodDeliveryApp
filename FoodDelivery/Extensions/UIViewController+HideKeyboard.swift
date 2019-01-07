//
//  UIViewController+HideKeyboard.swift
//  FoodDelivery
//
//  Created by Jon McLean on 6/1/19.
//  Copyright © 2019 Jon McLean Development. All rights reserved.
//

import UIKit

extension UIViewController {
    func hideKeyboardWhenTappedAround() {
        let tap = UITapGestureRecognizer(target: self, action: #selector(hideKeyboard))
        //tap.cancelsTouchesInView = false
        
        self.view.addGestureRecognizer(tap)
    }
    
    @objc func hideKeyboard() {
        view.endEditing(true)
    }
}
