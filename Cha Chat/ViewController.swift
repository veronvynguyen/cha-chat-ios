//
//  ViewController.swift
//  Cha Chat
//
//  Created by Vy Nguyen on 9/18/17.
//  Copyright © 2017 Vy Nguyen. All rights reserved.
//

import UIKit
import FirebaseAuth

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        logoutTEST()
        checkCurrentUser()
    }
    
    func logoutTEST() {
        let fAuth = Auth.auth()
        do {
            try fAuth.signOut()
        } catch let signOutError as NSError {
            print("error signing out: " + signOutError.localizedDescription)
        }
    }
    
    func checkCurrentUser () {
        if (Auth.auth().currentUser == nil) {
            let vc = self.storyboard?.instantiateViewController(withIdentifier: "authViewController")
            self.navigationController?.present(vc!, animated: true, completion: nil)
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

