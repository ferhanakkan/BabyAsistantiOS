//
//  ResetPasswordCollectionViewCell.swift
//  BabyAssistant
//
//  Created by Ferhan Akkan on 21.03.2020.
//  Copyright © 2020 Ferhan Akkan. All rights reserved.
//

import UIKit
import Firebase

class ResetPasswordCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var emailTextField: UITextField!
    
    var delegate : CollectionViewIndexPicker?
    
    @IBAction func reserPasswordPressed(_ sender: UIButton) {
        if emailTextField.text! == "" {
            AppManager.shared.messagePresent(title: "OOOPS", message: "You didn't enter any password", type: .error)
        } else {
            Auth.auth().sendPasswordReset(withEmail: emailTextField.text!) { error in
                if let error = error {
                    AppManager.shared.messagePresent(title: "OOOPS", message: error.localizedDescription, type: .error)
                } else {
                    AppManager.shared.messagePresent(title: "Success", message: "Reset Password Succesful, check your mailbox.", type: .success)
                    self.delegate?.selectedCollectionViewRoad(row: 2)
                }
            }
        }
        
    }
    @IBAction func logInPressed(_ sender: UIButton) {
        delegate?.selectedCollectionViewRoad(row: 2)
    }
}

