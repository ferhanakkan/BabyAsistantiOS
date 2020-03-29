//
//  TitleTopiceTableViewCell.swift
//  BabyAssistant
//
//  Created by Ferhan Akkan on 24.03.2020.
//  Copyright © 2020 Ferhan Akkan. All rights reserved.
//

import UIKit
import Firebase

 class TitleTopiceTableViewCell: UITableViewCell {
    
    @IBOutlet weak var avatarImageView: UIImageView!
    @IBOutlet weak var askedByLabel: UILabel!
    @IBOutlet weak var questionLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        avatarImageView.makeRounded()
        if askedByLabel.text != "Anonymous" {
            if let imageUrl = Auth.auth().currentUser?.photoURL {
                 avatarImageView.kf.setImage(with: imageUrl )
             } else {
                avatarImageView.image = UIImage(named: "avatar")
             }
        }
    }
    
}
