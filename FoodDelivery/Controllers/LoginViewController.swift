//
//  LoginViewController.swift
//  FoodDelivery
//
//  Created by Jon McLean on 6/1/19.
//  Copyright © 2019 Jon McLean Development. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController, UITextFieldDelegate {
    
    var backgroundImageView: UIImageView = UIImageView()
    
    var logoView: UIImageView = UIImageView()
    
    var detailsView: UIView = UIView()
    var phoneNumberField: UITextField = UITextField()
    var phoneNumberLabel: UILabel = UILabel()
    
    var errorLabel: UILabel = UILabel()
    
    var nextButton: RoundedButton = RoundedButton()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = UIColor.white
        
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide), name: UIResponder.keyboardWillHideNotification, object: nil)

        
        self.hideKeyboardWhenTappedAround()
        
        backgroundImageView = UIImageView(frame: CGRect(x: 0, y: 0, width: self.view.bounds.width, height: self.view.bounds.height))
        backgroundImageView.image = UIImage(named: "background")!
        backgroundImageView.contentMode = .scaleAspectFill
        //backgroundImageView.addBlurView(style: .light)
        self.view.addSubview(backgroundImageView)
        
        detailsView = UIView(frame: CGRect(x: 0, y: 0, width: self.view.bounds.width, height: self.view.bounds.height / 3 - 70))
        detailsView.backgroundColor = UIColor.white
        detailsView.layer.masksToBounds = false
        detailsView.layer.shadowColor = UIColor.lightGray.cgColor
        detailsView.layer.shadowRadius = 3
        detailsView.layer.shadowOffset = CGSize(width: 0, height: -2)
        detailsView.layer.shadowOpacity = 0.5
        
        self.view.addSubview(detailsView)
        
        logoView = UIImageView(frame: CGRect(x: 0, y: 0, width: self.view.bounds.width, height: 150))
        logoView.image = UIImage(named: "logo")!
        logoView.image = logoView.image!.withRenderingMode(.alwaysTemplate)
        logoView.contentMode = .scaleAspectFit
        logoView.tintColor = UIColor.black
        self.view.addSubview(logoView)
        
        phoneNumberField = UITextField(frame: CGRect(x: 0, y: 0, width: self.view.bounds.width - 45, height: 45))
        phoneNumberField.borderStyle = .roundedRect
        phoneNumberField.autocapitalizationType = .none
        phoneNumberField.autocorrectionType = .no
        phoneNumberField.keyboardType = .phonePad
        phoneNumberField.returnKeyType = .done
        phoneNumberField.clearButtonMode = .whileEditing
        phoneNumberField.contentVerticalAlignment = .center
        phoneNumberField.layer.cornerRadius = 1.5
        phoneNumberField.textColor = Colors.Theme.blueColor
        phoneNumberField.font = UIFont(name: "Courier New", size: 17)
        phoneNumberField.delegate = self
        phoneNumberField.tintColor = UIColor.white
        phoneNumberField.contentVerticalAlignment = .bottom
        self.detailsView.addSubview(phoneNumberField)
        
        phoneNumberLabel = UILabel(frame: CGRect(x: 0, y: 0, width: phoneNumberField.bounds.width, height: 14))
        phoneNumberLabel.text = "PHONE NUMBER"
        phoneNumberLabel.textColor = Colors.Theme.blueColor
        phoneNumberLabel.font = UIFont(name: "Courier New", size: 12)
        self.detailsView.addSubview(phoneNumberLabel)
        
        nextButton = RoundedButton(frame: CGRect(x: 0, y: 0, width: phoneNumberField.bounds.width - 30, height: 45))
        nextButton.setTitle("Next", for: .normal)
        nextButton.setTitleColor(UIColor.white, for: .normal)
        nextButton.backgroundColor = Colors.Theme.blueColor
        nextButton.addTarget(self, action: #selector(nextStage), for: .touchUpInside)
        self.detailsView.addSubview(nextButton)
        
        errorLabel = UILabel(frame: CGRect(x: 0, y: 0, width: nextButton.bounds.width, height: 14))
        errorLabel.font = UIFont(name: "New Courier", size: 12)
        errorLabel.textColor = Colors.Theme.redColor
        errorLabel.textAlignment = .center
        
        self.detailsView.addSubview(errorLabel)
        
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
        
        backgroundImageView.snp.makeConstraints { (make) in
            make.width.equalTo(backgroundImageView.bounds.width)
            make.height.equalTo(backgroundImageView.bounds.height)
            make.center.equalTo(self.view)
        }
        
        detailsView.snp.makeConstraints { (make) in
            make.width.equalTo(detailsView.bounds.width)
            make.height.equalTo(detailsView.bounds.height)
            make.bottom.equalTo(self.view.snp.bottom)
            make.centerX.equalTo(self.view)
        }
        
        logoView.snp.makeConstraints { (make) in
            make.width.equalTo(logoView.bounds.width)
            make.height.equalTo(logoView.bounds.height)
            make.centerX.equalTo(self.view)
            make.top.equalTo(self.view).offset(100)
        }
        
        phoneNumberField.snp.makeConstraints { (make) in
            make.width.equalTo(phoneNumberField.bounds.width)
            make.height.equalTo(phoneNumberField.bounds.height)
            make.centerX.equalTo(detailsView)
            make.top.equalTo(detailsView.snp.top).offset(20)
        }
        
        phoneNumberLabel.snp.makeConstraints { (make) in
            make.width.equalTo(phoneNumberLabel.bounds.width)
            make.height.equalTo(phoneNumberLabel.bounds.height)
            //make.centerX.equalTo(self.detailsView)
            make.top.equalTo(phoneNumberField.snp.top).offset(3)
            make.left.equalTo(phoneNumberField.snp.left).offset(10)
        }
        
        nextButton.snp.makeConstraints { (make) in
            make.width.equalTo(nextButton.bounds.width)
            make.height.equalTo(nextButton.bounds.height)
            make.centerX.equalTo(detailsView)
            make.top.equalTo(phoneNumberField.snp.bottom).offset(25)
        }
        
        errorLabel.snp.makeConstraints { (make) in
            make.width.equalTo(errorLabel.bounds.width)
            make.height.equalTo(errorLabel.bounds.height)
            make.centerX.equalTo(detailsView)
            make.top.equalTo(nextButton.snp.bottom).offset(15)
        }
        
    }
    
    @objc func keyboardWillShow(notification: NSNotification) {
        if let keyboardSize = (notification.userInfo?[UIResponder.keyboardFrameBeginUserInfoKey] as? NSValue)?.cgRectValue {
            if self.view.frame.origin.y == 0 {
                self.view.frame.origin.y -= keyboardSize.height
            }
        }
    }
    
    @objc func keyboardWillHide(notification: NSNotification) {
        if self.view.frame.origin.y != 0 {
            self.view.frame.origin.y = 0
        }
    }
    
    @objc func nextStage() {
        self.hideKeyboard()
        errorLabel.text = ""
        
        if(phoneNumberField.text == "" || phoneNumberField.text == nil) {
            errorLabel.text = "Please enter a valid phone number"
        }else {
            print("Checking phone number")
            if(phoneNumberField.text?.range(of: "^[0-9]*$", options: .regularExpression, range: nil, locale: nil) != nil) {
                // Make api call to see if register or not
                var isRegistered: Bool = false
                
                if(isRegistered) {
                    // sign in page
                }else {
                    // sign up page
                }
            }
        }
        
        
    }
    
}
