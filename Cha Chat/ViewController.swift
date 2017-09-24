//
//  ViewController.swift
//  Cha Chat
//
//  Created by Vy Nguyen on 9/18/17.
//  Copyright © 2017 Vy Nguyen. All rights reserved.
//

import UIKit
import Firebase
import FirebaseAuth

class ViewController: UIViewController, UITableViewDataSource, UITableViewDelegate, UITextFieldDelegate {

    @IBOutlet weak var messageTextfield: UITextField!
    var messages: [DataSnapshot] = [DataSnapshot] ()
    
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.

        checkCurrentUser()
        tableView.delegate = self
        tableView.dataSource = self
        messageTextfield.delegate = self
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        print("message writing ended")
        self.view.endEditing(true)
        return true
    }
    // mark tableview end
    func checkCurrentUser () {
        if (Auth.auth().currentUser == nil) {
            let vc = self.storyboard?.instantiateViewController(withIdentifier: "authViewController")
            self.navigationController?.present(vc!, animated: true, completion: nil)
        }
    }
    // mark tableview start
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return messages.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: UITableViewCell = tableView.dequeueReusableCell(withIdentifier: "messageTableViewCell")!
        let message = messages[indexPath.row]
        let msgContent = message.value as! Dictionary<String, String>
        let text = msgContent[Constants.MessageFields.text] as String!
        cell.textLabel?.text = text
        return cell
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    
    
    func logoutTEST() {
        let fAuth = Auth.auth()
        do {
            try fAuth.signOut()
        } catch let signOutError as NSError {
            print("error signing out: " + signOutError.localizedDescription)
        }
    }
}

