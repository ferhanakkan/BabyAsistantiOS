//
//  RegisterCollectionViewCell.swift
//  BabyAssistant
//
//  Created by Ferhan Akkan on 21.03.2020.
//  Copyright © 2020 Ferhan Akkan. All rights reserved.
//

import UIKit
import BEMCheckBox
import Firebase

class RegisterCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var usernameTextField: UITextField!
    @IBOutlet weak var checkBoxView: BEMCheckBox!
    @IBOutlet weak var eyeButtonOutlet: UIButton!
    @IBOutlet weak var registerButtonOutlet: UIButton!
    
    var delegate : CollectionViewIndexPicker?
    
    let firebaseService = FirebaseService()
    
    
    @IBAction func buttonPressed(_ sender: UIButton) {
        
        switch sender.currentTitle {
        case "Register":
            register()
        case "Log In":
            logIn()
        case "":
            passwordTextField.isSecureTextEntry = !passwordTextField.isSecureTextEntry
            DispatchQueue.main.async {
                self.setEyeImage()
            }
        default:
            break
        }
    }
    
    private func logIn() {
        delegate?.selectedCollectionViewRoad(row: 1)
    }
    
    private func register() {
        rememberMeSetter()
        if emailTextField.text == "" || passwordTextField.text == "" {
            AppManager.shared.messagePresent(title: "OOOPS!", message: "Please enter your E-mail or Password please ", type: .error)
        } else {
            firebaseService.createUser(email: emailTextField.text!, password: passwordTextField.text!, username: usernameTextField.text!) { (_) in
                self.window?.rootViewController = Tabbar.createTabBarWithNavigationBar(owner: self)
            }
        }
    }
        
    private func rememberMeSetter() {
        if checkBoxView.on {
            UserDefaults.standard.setValue(true, forKey: "rememberMe")
        } else {
            UserDefaults.standard.setValue(false, forKey: "rememberMe")
        }
    }
    
    private func setEyeImage() {
        if passwordTextField.isSecureTextEntry {
            eyeButtonOutlet.setImage(UIImage(named: "eyeHidden"), for: .normal)
        } else {
            eyeButtonOutlet.setImage(UIImage(named: "eye"), for: .normal)
        }
    }
    
}
