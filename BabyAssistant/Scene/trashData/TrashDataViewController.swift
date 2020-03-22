//
//  TrashDataViewController.swift
//  BabyAssistant
//
//  Created by Ferhan Akkan on 17.03.2020.
//  Copyright © 2020 Ferhan Akkan. All rights reserved.
//

import UIKit
import Firebase

class TrashDataViewController: BaseViewController {
    
    @IBOutlet weak var buttonPressed: UIButton!
    
    @IBAction func buttonAction(_ sender: UIButton) {
        let firebaseAuth = Auth.auth()
        do {
          try firebaseAuth.signOut()
            self.view.window?.rootViewController = NavigationBar.createNavigatonController(owner: self)
        } catch let signOutError as NSError {
          print ("Error signing out: %@", signOutError)
        }
        
    }
}
