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
    
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }

}
