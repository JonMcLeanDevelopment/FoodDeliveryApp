//
//  RegisterAccountController.swift
//  FoodDelivery
//
//  Created by Jon McLean on 8/1/19.
//  Copyright © 2019 Jon McLean Development. All rights reserved.
//

import UIKit
import SwiftyJSON

class RegisterAccountController: UIViewController, UITextFieldDelegate {
    
    var phoneNumber: String = ""
    
    var logoView: UIImageView = UIImageView()
    
    var phoneField: UITextField = UITextField()
    var fullNameField: UITextField = UITextField()
    var passwordField: UITextField = UITextField()
    var confirmField: UITextField = UITextField()
    var emailField: UITextField = UITextField()
    
    var phoneLabel: UILabel = UILabel()
    var nameLabel: UILabel = UILabel()
    var fullNameLabel: UILabel = UILabel()
    var passwordLabel: UILabel = UILabel()
    var confirmLabel: UILabel = UILabel()
    var emailLabel: UILabel = UILabel()
    var errorLabel: UILabel = UILabel()
    
    var registerButton: RoundedButton = RoundedButton()
    
    let valid = ValidUtil()
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
        
        fullNameField = UITextField(frame: CGRect(x: 0, y: 0, width: self.view.bounds.width - 45, height: 45))
        fullNameField.borderStyle = .roundedRect
        fullNameField.autocapitalizationType = .none
        fullNameField.autocorrectionType = .no
        fullNameField.keyboardType = .asciiCapable
        fullNameField.returnKeyType = .done
        fullNameField.clearButtonMode = .whileEditing
        fullNameField.contentVerticalAlignment = .center
        fullNameField.layer.cornerRadius = 1.5
        fullNameField.textColor = Colors.Theme.blueColor
        fullNameField.font = UIFont(name: "Courier New", size: 17)
        fullNameField.delegate = self
        fullNameField.tintColor = UIColor.white
        fullNameField.contentVerticalAlignment = .bottom
        self.view.addSubview(fullNameField)
        
        fullNameLabel = UILabel(frame: CGRect(x: 0, y: 0, width: fullNameField.bounds.width, height: 14))
        fullNameLabel.text = "FULL NAME"
        fullNameLabel.textColor = Colors.Theme.blueColor
        fullNameLabel.font = UIFont(name: "Courier New", size: 12)
        self.view.addSubview(fullNameLabel)
        
        emailField = UITextField(frame: CGRect(x: 0, y: 0, width: self.view.bounds.width - 45, height: 45))
        emailField.borderStyle = .roundedRect
        emailField.autocapitalizationType = .none
        emailField.autocorrectionType = .no
        emailField.keyboardType = .emailAddress
        emailField.returnKeyType = .done
        emailField.clearButtonMode = .whileEditing
        emailField.contentVerticalAlignment = .center
        emailField.layer.cornerRadius = 1.5
        emailField.textColor = Colors.Theme.blueColor
        emailField.font = UIFont(name: "Courier New", size: 17)
        emailField.delegate = self
        emailField.tintColor = UIColor.white
        emailField.contentVerticalAlignment = .bottom
        self.view.addSubview(emailField)
        
        emailLabel = UILabel(frame: CGRect(x: 0, y: 0, width: fullNameField.bounds.width, height: 14))
        emailLabel.text = "EMAIL"
        emailLabel.textColor = Colors.Theme.blueColor
        emailLabel.font = UIFont(name: "Courier New", size: 12)
        self.view.addSubview(emailLabel)
        
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
        
        passwordLabel = UILabel(frame: CGRect(x: 0, y: 0, width: fullNameField.bounds.width, height: 14))
        passwordLabel.text = "PASSWORD"
        passwordLabel.textColor = Colors.Theme.blueColor
        passwordLabel.font = UIFont(name: "Courier New", size: 12)
        self.view.addSubview(passwordLabel)
        
        confirmField = UITextField(frame: CGRect(x: 0, y: 0, width: self.view.bounds.width - 45, height: 45))
        confirmField.borderStyle = .roundedRect
        confirmField.autocapitalizationType = .none
        confirmField.autocorrectionType = .no
        confirmField.keyboardType = .asciiCapable
        confirmField.returnKeyType = .done
        confirmField.clearButtonMode = .whileEditing
        confirmField.contentVerticalAlignment = .center
        confirmField.layer.cornerRadius = 1.5
        confirmField.textColor = Colors.Theme.blueColor
        confirmField.font = UIFont(name: "Courier New", size: 17)
        confirmField.delegate = self
        confirmField.tintColor = UIColor.white
        confirmField.contentVerticalAlignment = .bottom
        confirmField.isSecureTextEntry = true
        self.view.addSubview(confirmField)
        
        confirmLabel = UILabel(frame: CGRect(x: 0, y: 0, width: fullNameField.bounds.width, height: 14))
        confirmLabel.text = "CONFIRM PASSWORD"
        confirmLabel.textColor = Colors.Theme.blueColor
        confirmLabel.font = UIFont(name: "Courier New", size: 12)
        self.view.addSubview(confirmLabel)
        
        registerButton = RoundedButton(frame: CGRect(x: 0, y: 0, width: confirmField.bounds.width - 30, height: 45))
        registerButton.setTitle("Register", for: .normal)
        registerButton.setTitleColor(UIColor.white, for: .normal)
        registerButton.backgroundColor = Colors.Theme.blueColor
        registerButton.addTarget(self, action: #selector(registerAccount), for: .touchUpInside)
        self.view.addSubview(registerButton)
        
        errorLabel = UILabel(frame: CGRect(x: 0, y: 0, width: registerButton.bounds.width, height: 14))
        errorLabel.text = ""
        errorLabel.textColor = Colors.Theme.redColor
        errorLabel.font = UIFont(name: "Courier New", size: 12)
        errorLabel.textAlignment = .center
        self.view.addSubview(errorLabel)
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        layoutViews()
        
        self.navigationItem.title = "Register Account"
        
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
        
        fullNameField.snp.makeConstraints { (make) in
            make.width.equalTo(fullNameField.bounds.width)
            make.height.equalTo(fullNameField.bounds.height)
            make.centerX.equalTo(self.view)
            make.top.equalTo(phoneField.snp.bottom).offset(25)
        }
        
        fullNameLabel.snp.makeConstraints { (make) in
            make.width.equalTo(fullNameLabel.bounds.width)
            make.height.equalTo(fullNameLabel.bounds.height)
            make.top.equalTo(fullNameField).offset(3)
            make.left.equalTo(fullNameField).offset(6)
        }
        
        emailField.snp.makeConstraints { (make) in
            make.width.equalTo(emailField.bounds.width)
            make.height.equalTo(emailField.bounds.height)
            make.centerX.equalTo(self.view)
            make.top.equalTo(fullNameField.snp.bottom).offset(25)
        }
        
        emailLabel.snp.makeConstraints { (make) in
            make.width.equalTo(emailLabel.bounds.width)
            make.height.equalTo(emailLabel.bounds.height)
            make.top.equalTo(emailField).offset(3)
            make.left.equalTo(emailField).offset(6)
        }
        
        passwordField.snp.makeConstraints { (make) in
            make.width.equalTo(passwordField.bounds.width)
            make.height.equalTo(passwordField.bounds.height)
            make.centerX.equalTo(self.view)
            make.top.equalTo(emailField.snp.bottom).offset(25)
        }
        
        passwordLabel.snp.makeConstraints { (make) in
            make.width.equalTo(passwordLabel.bounds.width)
            make.height.equalTo(passwordLabel.bounds.height)
            make.top.equalTo(passwordField).offset(3)
            make.left.equalTo(passwordField).offset(6)
        }
        
        confirmField.snp.makeConstraints { (make) in
            make.width.equalTo(confirmField.bounds.width)
            make.height.equalTo(confirmField.bounds.height)
            make.centerX.equalTo(self.view)
            make.top.equalTo(passwordField.snp.bottom).offset(25)
        }
        
        confirmLabel.snp.makeConstraints { (make) in
            make.width.equalTo(confirmLabel.bounds.width)
            make.height.equalTo(confirmLabel.bounds.height)
            make.top.equalTo(confirmField).offset(3)
            make.left.equalTo(confirmField).offset(6)
        }
        
        registerButton.snp.makeConstraints { (make) in
            make.width.equalTo(registerButton.bounds.width)
            make.height.equalTo(registerButton.bounds.height)
            make.top.equalTo(confirmField.snp.bottom).offset(40)
            make.centerX.equalTo(self.view)
        }
        
        errorLabel.snp.makeConstraints { (make) in
            make.width.equalTo(errorLabel.bounds.width)
            make.height.equalTo(errorLabel.bounds.height)
            make.top.equalTo(registerButton.snp.bottom).offset(15)
            make.centerX.equalTo(self.view)
        }
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        self.hideKeyboard()
        return true
    }
    
    @objc func registerAccount() {
        self.hideKeyboard()
        self.errorLabel.text = ""
        if(emailField.text == "" || emailField.text == nil || phoneField.text == "" || phoneField.text == nil || fullNameField.text == "" || fullNameField.text == nil || passwordField.text == "" || passwordField.text == nil || confirmField.text == "" || confirmField.text == nil) {
            self.errorLabel.text = "Please fill out all fields"
            return;
        }
        
        if(valid.checkEmailValidity(email: emailField.text!) == false) {
            self.errorLabel.text = "Please enter a valid email"
            return;
        }
        
        if phoneField.text!.range(of: "^[0-9]*$", options: .regularExpression, range: nil, locale: nil) == nil {
            self.errorLabel.text = "Please enter a valid phone number"
            return;
        }
        
        // TODO: Add password validation.
        
        if(passwordField.text! != confirmField.text!) {
            self.errorLabel.text = "Your passwords do not match"
        }
        
        network.registerUser(phoneNumber: phoneField.text!, fullName: fullNameField.text!, email: emailField.text!, password: passwordField.text!) { (response) in
            print(response)
            
            let json = JSON(parseJSON: response as! String)
            
            if json == nil {
                self.errorLabel.text = "There was a problem while contacting server. Please try again later!"
                return;
            }
            
            let dic = json.dictionaryObject
            
            let code = dic!["code"] as! Int
            if code != 200 {
                self.errorLabel.text = "There was a problem while contacting server. Please try again later!"
                return;
            }else {
                
                let vc = LoginViewController()
                vc.phoneNumber = self.phoneNumber
                
                self.navigationController?.pushViewController(vc, animated: true)
            }
        }
        
    }
        
    
}
