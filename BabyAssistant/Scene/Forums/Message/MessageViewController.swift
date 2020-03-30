//
//  MessageViewController.swift
//  BabyAssistant
//
//  Created by Ferhan Akkan on 24.03.2020.
//  Copyright © 2020 Ferhan Akkan. All rights reserved.
//

import UIKit
import Firebase

final class MessageViewController: UIViewController {
    
    internal var  tableView: UITableView? = nil
    internal var  sendButton: UIButton? = nil
    internal var  messageTextfield: UITextField? = nil
    
    private lazy var messageViewModel = MessageViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .white
        messageViewModel.setTableView(self)
        messageViewModel.getMessage(owner: self)
        messageViewModel.setSenderView(owner: self)
        sendButton!.addTarget(self, action: #selector(buttonAction), for: .touchUpInside)
    }
    
    
    @objc func buttonAction(owner: MessageViewController) {
        messageViewModel.sendMessage(owner: self)
    }
    
}

//MARK: - Table View Delegate & DataSource

extension MessageViewController: UITableViewDataSource , UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if indexPath.section == 0 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "TitleTopiceTableViewCell", for: indexPath) as! TitleTopiceTableViewCell
            messageViewModel.getUserImage(username: messageViewModel.messageModel[indexPath.section].username) { (data) in
                DispatchQueue.main.async {
                    cell.avatarImageView.image = UIImage(data: data)
                }
            }
            cell.askedByLabel.text = messageViewModel.messageModel[indexPath.section].username
            cell.questionLabel.text = messageViewModel.messageModel[indexPath.section].title
            return cell
        } else {
            let cell = tableView.dequeueReusableCell(withIdentifier: "MessageTableViewCell", for: indexPath) as! MessageTableViewCell
            cell.label.text = messageViewModel.messageModel[indexPath.section].title
            if Auth.auth().currentUser!.displayName == messageViewModel.messageModel[indexPath.section].username {
                cell.rightImageView.layer.borderColor = UIColor.gray.cgColor
                cell.leftImageView.isHidden = true
                cell.rightImageView.isHidden = false
                cell.backgroundColor = .backgroundGreen
                cell.messageBubble.backgroundColor = .gray
                
            } else {
                messageViewModel.getUserImage(username: messageViewModel.messageModel[indexPath.section].username) { (data) in
                    DispatchQueue.main.async {
                        cell.leftImageView.image = UIImage(data: data)
                    }
                }
                cell.leftImageView.layer.borderColor = UIColor.backgroundGreen.cgColor
                cell.rightImageView.isHidden = true
                cell.leftImageView.isHidden = false
                cell.backgroundColor = .gray
                cell.messageBubble.backgroundColor = .backgroundGreen
            }
            return cell
        }
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return messageViewModel.messageModel.count
    }
    
    // Set the spacing between sections
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 5
    }
    
    // Make the background color show through
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerView = UIView()
        headerView.backgroundColor = UIColor.clear
        return headerView
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    
}
