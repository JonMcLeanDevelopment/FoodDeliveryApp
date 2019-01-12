//
//  HomeTabBarController.swift
//  FoodDelivery
//
//  Created by Jon McLean on 8/1/19.
//  Copyright © 2019 Jon McLean Development. All rights reserved.
//

import UIKit

class HomeTabBarController: UITabBarController, UITabBarControllerDelegate {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        delegate = self
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        
        let placesIcon = UIImage(named: "places")!.withRenderingMode(.alwaysTemplate)
        let placesItem = UITabBarItem(title: "Places", image: placesIcon, tag: 111)
        let placesController = PlacesViewController()
        placesController.tabBarItem = placesItem
        
        let previousIcon = UIImage(named: "receipt")!.withRenderingMode(.alwaysTemplate)
        let previousItem = UITabBarItem(title: "Previous", image: previousIcon, tag: 112)
        let previousController = PreviousOrdersController()
        previousController.tabBarItem = previousItem
        
        let controllers = [placesController, previousController]
        self.viewControllers = controllers
        
        self.tabBar.tintColor = UIColor.black
    }
    
    func tabBarController(_ tabBarController: UITabBarController, shouldSelect viewController: UIViewController) -> Bool {
        print("Selected view controller: \(String(describing: viewController.title))")
        return true
    }
    
}
