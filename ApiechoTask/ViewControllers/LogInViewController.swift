//
//  ViewController.swift
//  ApiechoTask
//
//  Created by Katerina on 27.02.18.
//  Copyright © 2018 Katerina. All rights reserved.
//

import UIKit
import SkyFloatingLabelTextField

class LogInViewController: UIViewController {

    //UI
    private let avatarImageView = UIImageView()
    private let titleLabel = UILabel()
    private let messageLabel = UILabel()
    private var bigButton = UIButton()
    private var smallButton = UIButton()
    private let nameTextField = SkyFloatingLabelTextField(frame: CGRect(x: 10, y: 100, width: 220, height: 30))
    private let emailTextField = SkyFloatingLabelTextField(frame: CGRect(x: 10, y: 100, width: 220, height: 30))
    private let passwordTextField = SkyFloatingLabelTextField(frame: CGRect(x: 10, y: 100, width: 220, height: 30))
    
    //DataSource
    let title1 = "LOGIN"
    let title2 = "SIGN UP WITH EMAIL"
    let message1 = "Don't have an account?"
    let message2 = "Already have an account?"
    let titleBigButton1 = "GO!"
    let titleBigButton2 = "GET STARTED!"
    let titleSmallButton1 = "Sign Up"
    let titleSmallButton2 = "Login"
    var isSignIn = true
    var logInViewModel = LogInViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
//        if UserDefaults.standard.string(forKey: "accessToken") != nil {
//            //            self.performSegue(withIdentifier: "", sender: nil)
//        } else {
            setUI(isSignIn: isSignIn)
            setKeyboardNotification()
//        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        nameTextField.resignFirstResponder()
        emailTextField.resignFirstResponder()
        passwordTextField.resignFirstResponder()
    }
}

// MARK: - Private

extension LogInViewController  {
    
    fileprivate func setUI(isSignIn: Bool) {
        
        nameTextField.delegate = self
        emailTextField.delegate = self
        passwordTextField.delegate = self
        
        avatarImageView.image = UIImage(named: "mainAvatar")
        
        isSignIn == true ? (titleLabel.text = title1) : (titleLabel.text = title2)
        titleLabel.font = UIFont.systemFont(ofSize: 16)
        titleLabel.textColor = UIColor.darkGray
        
        bigButton.backgroundColor = UIColor.CustomColors.darkRed
        bigButton.tintColor = UIColor.white
        bigButton.layer.cornerRadius = 10
        isSignIn == true ? (bigButton.setTitle(titleBigButton1, for: .normal)) : (bigButton.setTitle(titleBigButton2, for: .normal))
        bigButton.addTarget(self, action: #selector(bigButtonAction), for: .touchUpInside)
        
        isSignIn == true ? (messageLabel.text = message1) : (messageLabel.text = message2)
        messageLabel.font = UIFont.systemFont(ofSize: 14)
        messageLabel.textColor = UIColor.darkGray
        
        isSignIn == true ? (smallButton.setTitle(titleSmallButton1, for: .normal)) : (smallButton.setTitle(titleSmallButton2, for: .normal))
        smallButton.setTitleColor(UIColor.black, for: .normal)
        smallButton.titleLabel?.font = UIFont.boldSystemFont(ofSize: 14)
        smallButton.addTarget(self, action: #selector(smallButtonAction), for: .touchUpInside)
        
        nameTextField.tintColor = UIColor.CustomColors.darkRed
        nameTextField.textColor = UIColor.darkGray
        nameTextField.selectedTitleColor = UIColor.CustomColors.darkRed
        nameTextField.placeholder = "Name"
        nameTextField.title = "Name"
        nameTextField.text = ""
        
        emailTextField.tintColor = UIColor.CustomColors.darkRed
        emailTextField.textColor = UIColor.darkGray
        emailTextField.selectedTitleColor = UIColor.CustomColors.darkRed
        emailTextField.placeholder = "Email"
        emailTextField.title = "Email"
        emailTextField.text = "doit@d.com"
        emailTextField.keyboardType = UIKeyboardType.emailAddress
        
        passwordTextField.tintColor = UIColor.CustomColors.darkRed
        passwordTextField.textColor = UIColor.darkGray
        passwordTextField.selectedTitleColor = UIColor.CustomColors.darkRed
        passwordTextField.placeholder = "Password"
        passwordTextField.title = "Password"
        passwordTextField.text = "qqqqq"
        passwordTextField.isSecureTextEntry = true
        
        view.addSubview(avatarImageView)
        view.addSubview(titleLabel)
        if !isSignIn {
            view.addSubview(nameTextField)
        }
        view.addSubview(emailTextField)
        view.addSubview(passwordTextField)
        view.addSubview(bigButton)
        
        avatarImageView
            .centerXAnchor(equalTo: view.centerXAnchor)
            .topAnchor(equalTo: view.topAnchor, constant: 60)
            .heightAnchor(equalTo: 120)
            .widthAnchor(equalTo: 120)
        
        titleLabel
            .centerXAnchor(equalTo: view.centerXAnchor)
            .topAnchor(equalTo: avatarImageView.bottomAnchor, constant: 15)
        
        if !isSignIn {
            nameTextField
                .centerXAnchor(equalTo: view.centerXAnchor)
                .topAnchor(equalTo: titleLabel.bottomAnchor, constant: 20)
            
            emailTextField
                .centerXAnchor(equalTo: view.centerXAnchor)
                .topAnchor(equalTo: nameTextField.bottomAnchor, constant: 20)
            
        } else {
            emailTextField
                .centerXAnchor(equalTo: view.centerXAnchor)
                .topAnchor(equalTo: titleLabel.bottomAnchor, constant: 20)
        }
        
        passwordTextField
            .centerXAnchor(equalTo: view.centerXAnchor)
            .topAnchor(equalTo: emailTextField.bottomAnchor, constant: 20)
        
        bigButton
            .centerXAnchor(equalTo: view.centerXAnchor)
            .topAnchor(equalTo: passwordTextField.bottomAnchor, constant: 40)
            .heightAnchor(equalTo: 50)
            .widthAnchor(equalTo: 250)
        
        let stackView = UIStackView()
        stackView.axis  = UILayoutConstraintAxis.horizontal
        stackView.distribution  = UIStackViewDistribution.equalSpacing
        stackView.alignment = UIStackViewAlignment.center
        stackView.spacing   = 5
        
        smallButton
            .heightAnchor(equalTo: 30)
            .widthAnchor(equalTo: 80)
        
        stackView.addArrangedSubview(messageLabel)
        stackView.addArrangedSubview(smallButton)
        stackView.translatesAutoresizingMaskIntoConstraints = false
       
        view.addSubview(stackView)
        stackView
            .centerXAnchor(equalTo: view.centerXAnchor)
            .topAnchor(equalTo: bigButton.bottomAnchor, constant: 15)
    }
    
    @objc func bigButtonAction(sender: UIButton!) {
        nameTextField.resignFirstResponder()
        emailTextField.resignFirstResponder()
        passwordTextField.resignFirstResponder()
        
        if emailTextField.text == "" || passwordTextField.text == "" {
            createAlert(title: "Error in form", message: "Please enter your credentials")
        } else if !isValidEmail(email: emailTextField.text!) {
            createAlert(title: "Error in form", message: "Please enter the correct password")
        } else if nameTextField.text == "" && isSignIn == false {
            createAlert(title: "Error in form", message: "Please enter your credentials")
        } else {
            logInViewModel.dataRequest.email = emailTextField.text!
            logInViewModel.dataRequest.password = passwordTextField.text!
            logInViewModel.postLogin(completion: { (success) in
                if success {
                    // next page
                } else {
                    self.createAlert(title: "Error!", message: "Error message")
                }
            })
        }
    }
    
    @objc func smallButtonAction(sender: UIButton!) {
        nameTextField.resignFirstResponder()
        emailTextField.resignFirstResponder()
        passwordTextField.resignFirstResponder()
        
        for subview in self.view.subviews {
            subview.removeFromSuperview()
        }
        isSignIn == true ? (isSignIn = false) : (isSignIn = true)
        setUI(isSignIn: isSignIn)
    }
    
   fileprivate func isValidEmail(email: String) -> Bool {
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}"
        let emailTest = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        let result = emailTest.evaluate(with: email)
        return result
    }
}

// MARK: - UITextFieldDelegate

extension LogInViewController : UITextFieldDelegate {
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        self.view.endEditing(true)
        return true
    }
}

// MARK: - KeyboardNotification

extension LogInViewController {
    
    func setKeyboardNotification() {
        NotificationCenter.default.addObserver(self, selector: #selector(LogInViewController.keyboardWillShow), name: NSNotification.Name.UIKeyboardWillShow, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(LogInViewController.keyboardWillHide), name: NSNotification.Name.UIKeyboardWillHide, object: nil)
    }
    
    @objc func keyboardWillShow(notification: NSNotification) {
        if self.view.frame.origin.y == 0{
            self.view.frame.origin.y -= 130
        }
    }

    @objc func keyboardWillHide(notification: NSNotification) {
        if self.view.frame.origin.y != 0{
            self.view.frame.origin.y += 130
        }
    }
}
