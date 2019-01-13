//
//  RestaurantCell.swift
//  FoodDelivery
//
//  Created by Jon McLean on 11/1/19.
//  Copyright © 2019 Jon McLean Development. All rights reserved.
//

import UIKit

class RestaurantCell: UITableViewCell {
    
    @IBOutlet var placeImageView: UIImageView!
    @IBOutlet var nameLabel: UILabel!
    @IBOutlet var deliveryTimeLabel: UILabel!
    @IBOutlet var ratingLabel: UILabel!
    
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        placeImageView.layer.cornerRadius = 3.0
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }

}
