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
        avatarImageView.contentMode = .scaleAspectFill
        if askedByLabel.text != "Anonymous" {
            DispatchQueue.main.async {
                if let data = UserDefaults.standard.value(forKey: "profileImage") as? Data{
                    self.avatarImageView.image = UIImage(data: data)
                } else {
                    self.avatarImageView.image = UIImage(named: "avatar")
                }
            }
        }
    }
    
}
