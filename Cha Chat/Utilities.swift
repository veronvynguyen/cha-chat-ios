//
//  Utilities.swift
//  Cha Chat
//
//  Created by Vy Nguyen on 9/18/17.
//  Copyright © 2017 Vy Nguyen. All rights reserved.
//

import Foundation
import UIKit

class Utilities {
    func showAlert(title: String, message: String, vc: UIViewController)
    {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        vc.present(alert, animated: true, completion: nil)
    }
}
