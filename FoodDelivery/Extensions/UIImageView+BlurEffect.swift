//
//  UIImageView+BlurEffect.swift
//  FoodDelivery
//
//  Created by Jon McLean on 6/1/19.
//  Copyright © 2019 Jon McLean Development. All rights reserved.
//

import UIKit

extension UIImageView {
    
    func addBlurView(style: UIBlurEffect.Style) {
        
        let blurEffect = UIBlurEffect(style: style)
        let effectView = UIVisualEffectView(effect: blurEffect)
        effectView.frame = self.bounds
        
        effectView.alpha = 0.89
        
        effectView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        
        self.addSubview(effectView)
        
    }
    
}
