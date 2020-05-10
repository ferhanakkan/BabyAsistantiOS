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
    @IBOutlet weak var writenByLabel: UILabel!
    
    var data: Data? = nil {
        didSet {
            DispatchQueue.main.async {
                self.leftImageView.image = UIImage(data: self.data!)
            }
        }
    }
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        messageBubble.layer.cornerRadius = messageBubble.frame.size.height / 5
        
        rightImageView.contentMode = .scaleAspectFill
        leftImageView.contentMode = .scaleAspectFill
        rightImageView.makeRounded()
        leftImageView.makeRounded()
        
        
        DispatchQueue.main.async {
            if let data = UserDefaults.standard.value(forKey: "profileImage") as? Data{
                self.rightImageView.image = UIImage(data: data)
            } else {
                self.rightImageView.image = UIImage(named: "avatar")
            }
        }
    }

        override func setSelected(_ selected: Bool, animated: Bool) {
            super.setSelected(selected, animated: animated)

            // Configure the view for the selected state Deleteable message if its users message!!!
        }
}
