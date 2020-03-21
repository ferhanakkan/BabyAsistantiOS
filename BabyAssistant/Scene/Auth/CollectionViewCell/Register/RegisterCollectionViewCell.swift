//
//  RegisterCollectionViewCell.swift
//  BabyAssistant
//
//  Created by Ferhan Akkan on 21.03.2020.
//  Copyright © 2020 Ferhan Akkan. All rights reserved.
//

import UIKit
import M13Checkbox

class RegisterCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var usernameTextField: UITextField!
    @IBOutlet weak var checkBoxView: M13Checkbox!
    
    
    
    @IBAction func buttonPressed(_ sender: UIButton) {
        
        switch sender.currentTitle {
        case "Register":
            print("Test")
        case "Log In":
            print("test 2")
        case "":
            print("test 3")
        default:
            break
        }
        
    }
}
