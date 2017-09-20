//
//  AuthViewController.swift
//  Cha Chat
//
//  Created by Vy Nguyen on 9/18/17.
//  Copyright © 2017 Vy Nguyen. All rights reserved.
//

import UIKit
import FirebaseAuth

class AuthViewController: UIViewController {

    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    
    var loggingIn = true
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
         let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(AuthViewController.dismissKeyboard))
        view.addGestureRecognizer(tap)
    }
    
    @objc func dismissKeyboard () {
        view.endEditing(true)
    }
    
    @IBAction func loginClicked(_ sender: Any) {
        login()
    }
    
    @IBAction func registerClicked(_ sender: Any) {
        register()
    }
    
    @IBAction func forgotPassClicked(_ sender: Any) {
        resetPassword()
    }
    
    func register () {
        if (!checkInput()) {
            return
        }
        let alert = UIAlertController(title: "Register", message: "Please confirm password", preferredStyle: .alert)
        alert.addTextField { (textField) in
            textField.isSecureTextEntry = true
            textField.placeholder = "password"
        }
        alert.addAction(UIAlertAction(title: "Cancel", style: .default, handler: nil))
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: { (action) in
            let passwordConf = alert.textFields![0]
            if (passwordConf.text!.isEqual(self.passwordTextField.text!)) {
                // registration start!
                let email = self.emailTextField.text!
                let password = self.passwordTextField.text!
                
                Auth.auth().createUser(withEmail: email, password: password, completion: { (user, error) in
                    if let err = error {
                        print("reg failed: " + err.localizedDescription)
                        
                        Utilities().showAlert(title: "Error", message: err.localizedDescription, vc: self)
                        return
                    }
                    if let us = user {
                    
                        print("new user: " + us.email!)
                        self.dismiss(animated: true, completion: nil)
                    }
                })
            } else {
                
                Utilities().showAlert(title: "Error", message: "Passwords don't match", vc: self)
            }
        }))
        self.present(alert, animated: true, completion: nil)
    }
    
    func login () {
        if (!checkInput()) {
            return
        }
        if (emailTextField.text?.characters.count)! < 5 {
            emailTextField.backgroundColor = UIColor(red: 0.8, green: 0.1, blue: 0.1, alpha: 0.2)
            return
        } else {
            emailTextField.backgroundColor = UIColor.white
        }
        if (passwordTextField.text?.characters.count)! < 5 {
            passwordTextField.backgroundColor = UIColor(red: 0.8, green: 0.1, blue: 0.1, alpha: 0.2)
            return
        }
        else
        {
            passwordTextField.backgroundColor = UIColor.white
        }
        
        let email = emailTextField.text!
        let password = passwordTextField.text!
        
        Auth.auth().signIn(withEmail: email, password: password)
        { (user, error) in
            if let err = error {
                print("error signing in: " + err.localizedDescription)
                return
            }
            print ("Signed in: " + (user?.email)!)
        }
    }
   
    func checkInput() -> Bool {
        if (emailTextField.text?.characters.count)! < 5 {
            emailTextField.backgroundColor = UIColor(red: 0.8, green: 0.1, blue: 0.1, alpha: 0.2)
            Utilities().showAlert(title: "Error", message: "Email incorrectly formatted", vc: self)
            return false
        } else {
            emailTextField.backgroundColor = UIColor.white
        }
        if (passwordTextField.text?.characters.count)! < 5 {
            passwordTextField.backgroundColor = UIColor(red: 0.8, green: 0.1, blue: 0.1, alpha: 0.2)
            Utilities().showAlert(title: "Error", message: "Password too short", vc: self)
            return false
        } else {
            passwordTextField.backgroundColor = UIColor.white
        }
        return true
    }
    
    func resetPassword () {
        if (emailTextField.text!.isEmpty) {
            Utilities().showAlert(title: "Error", message: "Please enter your email address.", vc: self)
            return
        }
        let email = self.emailTextField.text!
        Auth.auth().sendPasswordReset(withEmail: email) { (error) in
            if let err = error {
                Utilities().showAlert(title: "Error", message: err.localizedDescription, vc: self)
                return
            }
            Utilities().showAlert(title: "Success!", message: "Please check your email inbox for a password reset link.", vc: self)
        }
    }
}
