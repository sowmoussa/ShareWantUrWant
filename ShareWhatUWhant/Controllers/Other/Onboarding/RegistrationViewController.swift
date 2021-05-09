//
//  RegistrationViewController.swift
//  ShareWhatUWhant
//
//  Created by Moussa SOW on 23/04/2021.
//

import UIKit

class RegistrationViewController: UIViewController {

    struct Constants {
        static let cornerRadius: CGFloat = 8.0
    }
    
    private let username: UITextField! = {
        let field = UITextField()
        field.placeholder = "Username "
        field.returnKeyType = .continue
        field.leftViewMode = .always
        field.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 10, height: 0))
        field.autocapitalizationType = .none
        field.autocorrectionType = .no
        field.layer.masksToBounds = true
        field.layer.cornerRadius = Constants.cornerRadius
        field.backgroundColor = .secondarySystemBackground
        field.layer.borderWidth = 1.0
        field.layer.borderColor = UIColor.secondaryLabel.cgColor
        return field
    }()
    
    private let email: UITextField! = {
        let field = UITextField()
        field.placeholder = "Email adress"
        field.returnKeyType = .continue
        field.leftViewMode = .always
        field.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 10, height: 0))
        field.autocapitalizationType = .none
        field.autocorrectionType = .no
        field.layer.masksToBounds = true
        field.layer.cornerRadius = Constants.cornerRadius
        field.backgroundColor = .secondarySystemBackground
        field.layer.borderWidth = 1.0
        field.layer.borderColor = UIColor.secondaryLabel.cgColor
        return field
    }()
    
    private let passwordField: UITextField = {
        let field = UITextField()
        field.placeholder = "Password"
        field.returnKeyType = .next
        field.leftViewMode = .always
        field.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 10, height: 0))
        field.autocapitalizationType = .none
        field.autocorrectionType = .no
        field.layer.masksToBounds = true
        field.layer.cornerRadius = Constants.cornerRadius
        field.isSecureTextEntry = true
        field.backgroundColor = .secondarySystemBackground
        field.layer.borderWidth = 1.0
        field.layer.borderColor = UIColor.secondaryLabel.cgColor
        return field
    }()
    
    private let registerButton: UIButton = {
        let button = UIButton()
        button.setTitle("Log in", for: .normal)
        button.layer.masksToBounds = true
        button.layer.cornerRadius = Constants.cornerRadius
        button.backgroundColor = .systemGreen
        button.setTitleColor(.white, for: .normal)
        
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        addSubviews()
        registerButton.addTarget(self, action: #selector(didTapRegister), for: .touchUpInside)
        username.delegate = self
        email.delegate = self
        passwordField.delegate = self
        view.backgroundColor = .red
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        username.frame = CGRect(x: 20, y: view.safeAreaInsets.top+10, width: view.width-40, height: 52)
        email.frame = CGRect(x: 20, y: username.bottom+10, width: view.width-40, height: 52)
        passwordField.frame = CGRect(x: 20, y: email.bottom+10, width: view.width-40, height: 52)
        registerButton.frame = CGRect(x: 20, y: passwordField.bottom+10, width: view.width-40, height: 52)
    }
    
    private func addSubviews() {
        view.addSubview(username)
        view.addSubview(passwordField)
        view.addSubview(registerButton)
        view.addSubview(email)
    }
    
    @objc func didTapRegister() {
        username.resignFirstResponder()
        email.resignFirstResponder()
        passwordField.resignFirstResponder()
        
        guard let mail = email.text, !mail.isEmpty, let name = username.text, !name.isEmpty, let password = passwordField.text, password.count>=8, !password.isEmpty else {
            return
        }
        AuthManager.shared.registerNewUser(username: name, email: mail, password: password) {
            (registered) in
            DispatchQueue.main.async {
                if registered {
                    
                }else{
                    
                }
            }
        }
    }
}

extension RegistrationViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if textField == username {
            email.becomeFirstResponder()
        } else if textField == email {
            passwordField.becomeFirstResponder()
        } else {
            didTapRegister()
        }
        return true
    }
}
