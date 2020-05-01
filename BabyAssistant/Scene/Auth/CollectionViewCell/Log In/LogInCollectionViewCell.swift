//
//  LogInCollectionViewCell.swift
//  BabyAssistant
//
//  Created by Ferhan Akkan on 21.03.2020.
//  Copyright © 2020 Ferhan Akkan. All rights reserved.
//

import UIKit
import BEMCheckBox
import Firebase

protocol CollectionViewIndexPicker {
    func selectedCollectionViewRoad(row: Int)
}

class LogInCollectionViewCell : UICollectionViewCell {
    
    
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var checkBox: BEMCheckBox!
    @IBOutlet weak var eyeButtonOutlet: UIButton!
    
    var delegate : CollectionViewIndexPicker?
    
    let firebaseService = FirebaseUser()
    
    lazy var width: NSLayoutConstraint = {
        let width = contentView.widthAnchor.constraint(equalToConstant: bounds.size.width)
        width.isActive = true
        return width
    }()
    
    @IBAction func buttonPressed(_ sender: UIButton) {
        switch sender.currentTitle {
        case "Register":
            register()
        case "Log In":
            logIn()
        case "Reset Password":
            resetPassword()
        case "":
            passwordTextField.isSecureTextEntry = !passwordTextField.isSecureTextEntry
            DispatchQueue.main.async {
                self.setEyeImage()
            }
        default:
            break
        }
    }
    
    private func register() {
        self.delegate?.selectedCollectionViewRoad(row: 0)
    }
    
    private func logIn() {
        rememberMeSetter()
        if emailTextField.text == "" || passwordTextField.text == "" {
            AppManager.shared.messagePresent(title: "OOOPS!", message: "Please enter your E-mail or Password please ", type: .error)
        } else {
            firebaseService.logIn(email: emailTextField.text!, password: passwordTextField.text!) { (_) in
                self.window?.rootViewController = Tabbar.createTabBarWithNavigationBar(owner: self)
            }
        }
    }
    
    private func resetPassword() {
        self.delegate?.selectedCollectionViewRoad(row: 2)
    }
    
    private func rememberMeSetter() {
        if checkBox.on {
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
    
    override func systemLayoutSizeFitting(_ targetSize: CGSize, withHorizontalFittingPriority horizontalFittingPriority: UILayoutPriority, verticalFittingPriority: UILayoutPriority) -> CGSize {
        width.constant = bounds.size.width
        return contentView.systemLayoutSizeFitting(CGSize(width: targetSize.width, height: bounds.size.height))
    }
}


