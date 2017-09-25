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

    @IBOutlet weak var messageTextField: UITextField!
    
    var messages: [DataSnapshot] = [DataSnapshot] ()
    var ref: DatabaseReference!
    var refHandle: DatabaseHandle!
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.

        checkCurrentUser()
        tableView.delegate = self
        tableView.dataSource = self
        messageTextField.delegate = self
        setupFirebase()
    }
    
    func setupFirebase () {
        ref = Database.database().reference()
        refHandle = ref.child("messages").observe(DataEventType.childAdded, with: { (dataSnapShot) in
            self.messages.append(dataSnapShot)
            self.tableView.insertRows(at: [IndexPath(row: self.messages.count-1, section: 0)], with: .automatic)
        })
    }
    
    deinit {
        ref.child("messages").removeObserver(withHandle: refHandle)
    }
    
    func sendMessage (data: [String: String]) {
        var packet = data
        packet[Constants.MessageFields.dateTime] = Utilities().getDate()
        ref.child("messages").childByAutoId().setValue(packet)
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if (textField.text!.characters.count < 1) {
            return false
        }
        let data = [Constants.MessageFields.text: textField.text!]
        sendMessage(data: data)
        print("message writing ended")
        self.view.endEditing(true)
        Utilities().clearTextField(textField: textField)
        return true
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
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
        if let text = msgContent[Constants.MessageFields.text]
        {
            cell.textLabel?.text = text
        }
        if let dateTime =  msgContent[Constants.MessageFields.dateTime]
        {
            cell.detailTextLabel?.text = dateTime
        }
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

