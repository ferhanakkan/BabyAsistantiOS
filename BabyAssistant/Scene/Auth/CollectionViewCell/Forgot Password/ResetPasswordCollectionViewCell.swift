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
    let firebaseService = FirebaseService()
    
    @IBAction func reserPasswordPressed(_ sender: UIButton) {
        if emailTextField.text! == "" {
            AppManager.shared.messagePresent(title: "OOOPS", message: "You didn't enter any password", type: .error)
        } else {
            firebaseService.resetPassword(email: emailTextField.text!) { (_) in
                self.delegate?.selectedCollectionViewRoad(row: 1)
            }
        }
        
    }
    @IBAction func logInPressed(_ sender: UIButton) {
        delegate?.selectedCollectionViewRoad(row: 1)
    }
    
//    override func preferredLayoutAttributesFitting(_ layoutAttributes: UICollectionViewLayoutAttributes) -> UICollectionViewLayoutAttributes {
////         self.preferredMaxLayoutWidth = layoutAttributes.size.width - contentView.layoutMargins.left - contentView.layoutMargins.left
//         layoutAttributes.bounds.size.height = systemLayoutSizeFitting(UIView.layoutFittingCompressedSize).height
//         return layoutAttributes
//     }
    
}

