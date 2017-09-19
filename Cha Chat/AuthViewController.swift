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
    }
    
    @IBAction func registerClicked(_ sender: Any) {
    }
    
    @IBAction func forgotPassClicked(_ sender: Any) {
    }
    
    func login () {
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
   
    

}
