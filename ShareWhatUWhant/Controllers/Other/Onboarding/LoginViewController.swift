//
//  LoginViewController.swift
//  ShareWhatUWhant
//
//  Created by Moussa SOW on 23/04/2021.
//

import UIKit
import SafariServices

class LoginViewController: UIViewController {

    struct Constants {
        static let cornerRadius: CGFloat = 8.0
    }
    
    private let usernameEmailField: UITextField! = {
        let field = UITextField()
        field.placeholder = "Username or email"
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
    
    private let loginButton: UIButton = {
        let button = UIButton()
        button.setTitle("Log in", for: .normal)
        button.layer.masksToBounds = true
        button.layer.cornerRadius = Constants.cornerRadius
        button.backgroundColor = .systemBlue
        button.setTitleColor(.white, for: .normal)
        
        return button
    }()
    
    private let privacyButton: UIButton = {
        let button = UIButton()
        button.setTitle("Terms of service", for: .normal)
        button.setTitleColor(.secondaryLabel, for: .normal)
        return button
    }()
    
    private let termsButton: UIButton = {
        let button = UIButton()
        button.setTitle("Terms of service", for: .normal)
        button.setTitleColor(.secondaryLabel, for: .normal)
        return button
    }()
    
    private let createAccountButton: UIButton = {
        let button = UIButton()
        button.setTitleColor(.label, for: .normal)
        button.setTitle("Signup", for: .normal)
        return button
    }()
    
    private let headerView: UIView = {
        let header = UIView()
        header.clipsToBounds = true
        header.backgroundColor = .red
        let backgroundImageView = UIImageView(image: UIImage(named: "gradient"))
        header.addSubview(backgroundImageView)
        return header
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loginButton.addTarget(self, action: #selector(didTapLoginButon), for: .touchUpInside)
        createAccountButton.addTarget(self, action: #selector(createAccount), for: .touchUpInside)
        termsButton.addTarget(self, action: #selector(didTapTermsButton), for: .touchUpInside)
        privacyButton.addTarget(self, action: #selector(didTapPrivacyButon), for: .touchUpInside)
        passwordField.delegate = self
        usernameEmailField.delegate = self
        addSubviews()
        view.backgroundColor = .systemBackground
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        // Assign Frames
        
        headerView.frame = CGRect(x: 0,
                                  y: 0.0,
                                  width: view.width,
                                  height: view.height/3.0
                           )
        usernameEmailField.frame = CGRect(x: 25,
                                          y: headerView.bottom + 40,
                                          width: view.width-50,
                                          height: 52.0
        )
        
        passwordField.frame = CGRect(x: 25,
                                     y: usernameEmailField.bottom + 10,
                                     width: view.width-50,
                                     height: 52.0
        )
        loginButton.frame = CGRect(x: 25,
                                     y: passwordField.bottom + 10,
                                     width: view.width-50,
                                     height: 52.0
        )
        createAccountButton.frame = CGRect(x: 25,
                                     y: loginButton.bottom + 10,
                                     width: view.width-50,
                                     height: 52.0
        )
        termsButton.frame = CGRect(x: 0,
                                   y: view.height-view.safeAreaInsets.bottom-50,
                                   width: view.width-20,
                                   height: 50)
        privacyButton.frame = CGRect(x: 0,
                                     y: view.height-view.safeAreaInsets.bottom-termsButton.height-50,
                                   width: view.width-20,
                                   height: 50)
        configureHeaderView()
    }
    
    private func configureHeaderView() {
        guard headerView.subviews.count == 1 else {
            return
        }
        
        guard let backgroundView = headerView.subviews.first else {
            return
        }
        backgroundView.frame = headerView.bounds
        
        // add logo
        let imageView = UIImageView(image: UIImage(named: "text"))
        headerView.addSubview(imageView)
        imageView.contentMode = .scaleAspectFit
        imageView.frame = CGRect(x: headerView.width/4.0,
                                 y: view.safeAreaInsets.top,
                                 width: headerView.width/2.0,
                                 height: headerView.height-view.safeAreaInsets.top)
    }
    
    private func addSubviews() {
        view.addSubview(usernameEmailField)
        view.addSubview(passwordField)
        view.addSubview(loginButton)
        view.addSubview(privacyButton)
        view.addSubview(termsButton)
        view.addSubview(headerView)
        view.addSubview(createAccountButton)
    }
    
    @objc private func didTapLoginButon() {
        passwordField.resignFirstResponder()
        usernameEmailField.resignFirstResponder()
        print(passwordField.text)
        guard let usernameEmail = usernameEmailField.text, !usernameEmail.isEmpty, let password = passwordField.text, !password.isEmpty, password.count>=8 else {
            print("error")
            return
        }
        
        var username: String?
        var email: String?
        
        //login function
        if usernameEmail.contains("@"), usernameEmail.contains(".") {
            // email
            email = usernameEmail
        } else {
            username = usernameEmail
        }
        AuthManager.shared.loginUser(username: username, email: email, password: password) { (success) in
            DispatchQueue.main.async {
                if success {
                    // log in
                    print("login")
                    self.dismiss(animated: true, completion: nil)
                } else {
                    // error
                    let alert = UIAlertController(title: "Error", message: "Vérifier vos identifiants", preferredStyle: .alert)
                    alert.addAction(UIAlertAction(title: "Dismiss", style: .cancel, handler: nil))
                    self.present(alert, animated: true, completion: nil)
                }
            }
        }
    }
    
    @objc private func didTapTermsButton() {
        guard let url = URL(string: "https://help.instagram.com/1215086795543252") else {
            return
        }
        let vc = SFSafariViewController(url: url)
        present(vc, animated: true, completion: nil)
    }
    
    @objc private func didTapPrivacyButon() {
        guard let url = URL(string: "https://help.instagram.com/519522125107875") else {
            return
        }
        let vc = SFSafariViewController(url: url)
        present(vc, animated: true, completion: nil)
    }
    @objc private func createAccount() {
        let vc = RegistrationViewController()
        vc.title = "Create Account"
        present(UINavigationController(rootViewController: vc), animated: true)
    }
}

extension LoginViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if textField == usernameEmailField {
            passwordField.becomeFirstResponder()
        } else if textField == passwordField {
            didTapLoginButon()
        }
        return true
    }
}

// 32 179 185
