//
//  RoundedButton.swift
//  FoodDelivery
//
//  Created by Jon McLean on 7/1/19.
//  Copyright © 2019 Jon McLean Development. All rights reserved.
//

import UIKit

class RoundedButton: UIButton {
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        self.layer.cornerRadius = frame.height / 2
    }
    
}
