//
//  LoginViewController.swift
//  FoodDelivery
//
//  Created by Jon McLean on 8/1/19.
//  Copyright © 2019 Jon McLean Development. All rights reserved.
//

import UIKit
import SwiftyJSON

class LoginViewController: UIViewController, UITextFieldDelegate {
    
    var phoneNumber: String = ""
    
    var logoView: UIImageView = UIImageView()
    var phoneField: UITextField = UITextField()
    var passwordField: UITextField = UITextField()
    
    var phoneLabel: UILabel = UILabel()
    var passwordLabel: UILabel = UILabel()
    var errorLabel: UILabel = UILabel()
    
    var signinButton: RoundedButton = RoundedButton()
    
    let network = NetworkManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.hideKeyboardWhenTappedAround()
        
        self.view.backgroundColor = UIColor.white
        
        self.navigationController?.isNavigationBarHidden = false
        
        logoView = UIImageView(frame: CGRect(x: 0, y: 0, width: self.view.bounds.width, height: 150))
        logoView.image = UIImage(named: "logo")!
        logoView.image = logoView.image!.withRenderingMode(.alwaysTemplate)
        logoView.contentMode = .scaleAspectFit
        logoView.tintColor = UIColor.black
        self.view.addSubview(logoView)
        
        phoneField = UITextField(frame: CGRect(x: 0, y: 0, width: self.view.bounds.width - 45, height: 45))
        phoneField.borderStyle = .roundedRect
        phoneField.autocapitalizationType = .none
        phoneField.autocorrectionType = .no
        phoneField.keyboardType = .phonePad
        phoneField.returnKeyType = .done
        phoneField.clearButtonMode = .whileEditing
        phoneField.contentVerticalAlignment = .center
        phoneField.layer.cornerRadius = 1.5
        phoneField.textColor = Colors.Theme.blueColor
        phoneField.font = UIFont(name: "Courier New", size: 17)
        phoneField.delegate = self
        phoneField.tintColor = UIColor.white
        phoneField.contentVerticalAlignment = .bottom
        phoneField.text = phoneNumber
        self.view.addSubview(phoneField)
        
        phoneLabel = UILabel(frame: CGRect(x: 0, y: 0, width: phoneField.bounds.width, height: 14))
        phoneLabel.text = "PHONE NUMBER"
        phoneLabel.textColor = Colors.Theme.blueColor
        phoneLabel.font = UIFont(name: "Courier New", size: 12)
        self.view.addSubview(phoneLabel)
        
        passwordField = UITextField(frame: CGRect(x: 0, y: 0, width: self.view.bounds.width - 45, height: 45))
        passwordField.borderStyle = .roundedRect
        passwordField.autocapitalizationType = .none
        passwordField.autocorrectionType = .no
        passwordField.keyboardType = .asciiCapable
        passwordField.returnKeyType = .done
        passwordField.clearButtonMode = .whileEditing
        passwordField.contentVerticalAlignment = .center
        passwordField.layer.cornerRadius = 1.5
        passwordField.textColor = Colors.Theme.blueColor
        passwordField.font = UIFont(name: "Courier New", size: 17)
        passwordField.delegate = self
        passwordField.tintColor = UIColor.white
        passwordField.contentVerticalAlignment = .bottom
        passwordField.isSecureTextEntry = true
        self.view.addSubview(passwordField)
        
        passwordLabel = UILabel(frame: CGRect(x: 0, y: 0, width: phoneField.bounds.width, height: 14))
        passwordLabel.text = "PASSWORD"
        passwordLabel.textColor = Colors.Theme.blueColor
        passwordLabel.font = UIFont(name: "Courier New", size: 12)
        self.view.addSubview(passwordLabel)
        
        signinButton = RoundedButton(frame: CGRect(x: 0, y: 0, width: passwordField.bounds.width - 30, height: 45))
        signinButton.setTitle("Sign In", for: .normal)
        signinButton.setTitleColor(UIColor.white, for: .normal)
        signinButton.backgroundColor = Colors.Theme.blueColor
        signinButton.addTarget(self, action: #selector(signinAccount), for: .touchUpInside)
        self.view.addSubview(signinButton)
        
        errorLabel = UILabel(frame: CGRect(x: 0, y: 0, width: signinButton.bounds.width, height: 14))
        errorLabel.textColor = Colors.Theme.redColor
        errorLabel.font = UIFont(name: "Courier New", size: 12)
        errorLabel.textAlignment = .center
        self.view.addSubview(errorLabel)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        layoutViews()
        
        self.navigationItem.title = "Sign In"
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.isNavigationBarHidden = false
        
    }
    
    
    func layoutViews() {
        logoView.snp.makeConstraints { (make) in
            make.width.equalTo(logoView.bounds.width)
            make.height.equalTo(logoView.bounds.height)
            make.centerX.equalTo(self.view)
            make.top.equalTo(self.navigationController!.navigationBar.snp.bottom).offset(10)
        }
        
        phoneField.snp.makeConstraints { (make) in
            make.width.equalTo(phoneField.bounds.width)
            make.height.equalTo(phoneField.bounds.height)
            make.centerX.equalTo(self.view)
            make.top.equalTo(logoView.snp.bottom).offset(15)
        }
        
        phoneLabel.snp.makeConstraints { (make) in
            make.width.equalTo(phoneLabel.bounds.width)
            make.height.equalTo(phoneLabel.bounds.height)
            make.top.equalTo(phoneField).offset(3)
            make.left.equalTo(phoneField).offset(6)
        }
        
        passwordField.snp.makeConstraints { (make) in
            make.width.equalTo(passwordField.bounds.width)
            make.height.equalTo(passwordField.bounds.height)
            make.centerX.equalTo(self.view)
            make.top.equalTo(phoneField.snp.bottom).offset(25)
        }
        
        passwordLabel.snp.makeConstraints { (make) in
            make.width.equalTo(passwordLabel.bounds.width)
            make.height.equalTo(passwordLabel.bounds.height)
            make.top.equalTo(passwordField).offset(3)
            make.left.equalTo(passwordField).offset(6)
        }
        
        signinButton.snp.makeConstraints { (make) in
            make.width.equalTo(signinButton.bounds.width)
            make.height.equalTo(signinButton.bounds.height)
            make.top.equalTo(passwordField.snp.bottom).offset(40)
            make.centerX.equalTo(self.view)
        }
        
        errorLabel.snp.makeConstraints { (make) in
            make.width.equalTo(errorLabel.bounds.width)
            make.height.equalTo(errorLabel.bounds.height)
            make.top.equalTo(signinButton.snp.bottom).offset(15)
            make.centerX.equalTo(self.view)
        }
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        self.hideKeyboard()
        return true
    }
    
    @objc func signinAccount() {
        self.errorLabel.text = ""
        self.hideKeyboard()
        if(phoneField.text == "" || phoneField.text == nil || passwordField.text == "" || passwordField.text == nil) {
            self.errorLabel.text = "Please fill out all fields"
            return;
        }
        
        if(phoneField.text!.range(of: "^[0-9]*$", options: .regularExpression, range: nil, locale: nil) == nil) {
            self.errorLabel.text = "Please enter a valid phone number"
        }
        
        network.loginUser(phoneNumber: phoneField.text!, password: passwordField.text!) { (response) in
            let json = JSON(parseJSON: response as! String)
            
            if json == nil {
                self.errorLabel.text = "There was a problem while contacting server. Please try again later!"
            }
            
            let dic = json.dictionaryObject
            let code = dic!["code"] as! Int
            
            if code == 400 {
                self.errorLabel.text = "Invalid phone number or password"
                return;
            }else if code == 200 { // Successfully
                
                // move to home views
                print("Logged in")
                
                self.navigationController?.pushViewController(HomeTabBarController(), animated: true)
                
            }else {
                self.errorLabel.text = "There was a problem while contacting server. Please try again later!"
            }
        }
        
    }
    
    
    
}
