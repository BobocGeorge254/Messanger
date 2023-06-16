//
//  LoginViewController.swift
//  Messanger
//
//  Created by George Boboc on 16.06.2023.
//

import UIKit
import FirebaseAuth

class LoginViewController: UIViewController {
    
    private let scrollView : UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.clipsToBounds = true
        return scrollView
    }()
    
    private let emailOrUsernameField : UITextField = {
        let field = UITextField()
        field.autocorrectionType = .no
        field.autocapitalizationType = .none
        field.returnKeyType = .continue
        field.layer.cornerRadius = 12
        field.layer.borderWidth = 1
        field.placeholder = "Email Address.."
        field.layer.borderColor = UIColor.lightGray.cgColor
        field.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 5, height: 0))
        field.leftViewMode = .always
        return field
    }()
    
    
    private let passwordField : UITextField = {
        let field = UITextField()
        field.autocorrectionType = .no
        field.autocapitalizationType = .none
        field.returnKeyType = .done
        field.layer.cornerRadius = 12
        field.layer.borderWidth = 1
        field.placeholder = "Password.."
        field.isSecureTextEntry = true
        field.layer.borderColor = UIColor.lightGray.cgColor
        field.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 5, height: 0))
        field.leftViewMode = .always
        return field
    }()
    
    private let imageView : UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "logo")
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    private let loginButton : UIButton = {
        let button = UIButton()
        button.setTitle("Log in", for: .normal)
        button.backgroundColor = .link
        button.setTitleColor(.white, for: .normal)
        button.layer.cornerRadius = 12
        button.titleLabel?.font = .systemFont(ofSize: 20, weight: .bold)
        return button
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Log in"
        view.backgroundColor = .white
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Register",
                                                            style: .done,
                                                            target: self,
                                                            action: #selector(didTapRegister))
        loginButton.addTarget(self,
                              action: #selector(loginButtonPressed),
                              for: .touchUpInside)
        
        emailOrUsernameField.delegate = self
        passwordField.delegate = self
        
        view.addSubview(scrollView)
        scrollView.addSubview(imageView)
        scrollView.addSubview(emailOrUsernameField)
        scrollView.addSubview(passwordField)
        scrollView.addSubview(loginButton)
        
    }
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        scrollView.frame = view.bounds

        let size = scrollView.width/3
        imageView.frame = CGRect (x: (scrollView.width - size)/2 ,
                                  y: 20,
                                  width: size,
                                  height: size)
        emailOrUsernameField.frame = CGRect (x: 30 ,
                                  y: (imageView.bottom + 10),
                                  width: scrollView.width - 60,
                                  height: 52)
        
        passwordField.frame = CGRect (x: 30 ,
                                  y: (emailOrUsernameField.bottom + 10),
                                  width: scrollView.width - 60,
                                  height: 52)
        loginButton.frame = CGRect (x: 30 ,
                                  y: (passwordField.bottom + 10),
                                  width: scrollView.width - 60,
                                  height: 52)
    }
    
    @objc private func didTapRegister() {
        let vc = RegisterViewController()
        vc.title = "Create account"
        navigationController?.pushViewController(vc, animated: true)
    }
    
    @objc private func loginButtonPressed() {
        guard let emailOrUsername = emailOrUsernameField.text,
              let password = passwordField.text, !emailOrUsername.isEmpty, !password.isEmpty else {
                alertUserLoginError()
            	return
        }
        FirebaseAuth.Auth.auth().signIn(withEmail: emailOrUsername, password: password) { authResult, error in
            if let error = error {
                print("Error signing in: \(error.localizedDescription)")
                // Show error message or alert for login failure
                return
            }
            else {
                print("Logged in on account " + emailOrUsername)
            }
        }
    }
    func alertUserLoginError() {
        let alert = UIAlertController(title: "Please try again!", message: "Please enter all information", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Dismiss", style: .cancel, handler: nil))
        present(alert, animated: true)
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}

extension LoginViewController : UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if (textField == emailOrUsernameField) {
            passwordField.becomeFirstResponder()
        }
        else if (textField == passwordField) {
            loginButtonPressed()
        }
        
        return true
    }
}
