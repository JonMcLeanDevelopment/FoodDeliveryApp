//
//  LoginViewController.swift
//  FoodDelivery
//
//  Created by Jon McLean on 6/1/19.
//  Copyright © 2019 Jon McLean Development. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController {
    
    var backgroundImageView: UIImageView = UIImageView()
    
    var detailsView: UIView = UIView()
    var phoneNumberField: UITextField = UITextField()
    var passwordField: UITextField = UITextField()
    var phoneNumberLabel: UILabel = UILabel()
    var passwordLabel: UILabel = UILabel()
    
    var loginButton: UIButton = UIButton()
    var signupButton: UIButton = UIButton()
    var forgotPasswordButton = UIButton()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = UIColor.white
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        layoutViews()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.isNavigationBarHidden = true
    }
    
    func layoutViews() {
        
    }
    
}
