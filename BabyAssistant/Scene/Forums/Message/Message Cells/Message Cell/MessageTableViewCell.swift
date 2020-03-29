//
//  MessageTableViewCell.swift
//  BabyAssistant
//
//  Created by Ferhan Akkan on 24.03.2020.
//  Copyright © 2020 Ferhan Akkan. All rights reserved.
//

import UIKit
import Firebase

final class MessageTableViewCell: UITableViewCell {
    
    @IBOutlet weak var messageBubble: UIView!
    @IBOutlet weak var label: UILabel!
    @IBOutlet weak var rightImageView: UIImageView!
    @IBOutlet weak var leftImageView: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        messageBubble.layer.cornerRadius = messageBubble.frame.size.height / 5
        
        if let imageUrl = Auth.auth().currentUser?.photoURL {
            rightImageView.kf.setImage(with: imageUrl )
            leftImageView.kf.setImage(with: imageUrl )
        } else {
            rightImageView.image = UIImage(named: "avatar")
            leftImageView.image = UIImage(named: "avatar")
        }
    }

        override func setSelected(_ selected: Bool, animated: Bool) {
            super.setSelected(selected, animated: animated)

            // Configure the view for the selected state Deleteable message if its users message!!!
        }
}
