//
//  MessageViewController.swift
//  BabyAssistant
//
//  Created by Ferhan Akkan on 24.03.2020.
//  Copyright © 2020 Ferhan Akkan. All rights reserved.
//

import UIKit

final class MessageViewController: UIViewController {
    
    internal var  tableView: UITableView? = nil
    
    private lazy var messageViewModel = MessageViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        messageViewModel.setTableView(self)
        messageViewModel.getMessage(owner: self)
    }
    
}

//MARK: - Table View Delegate & DataSource

extension MessageViewController: UITableViewDataSource , UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return messageViewModel.messageModel.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
//        if indexPath.row == 0 {
//            let cell = tableView.dequeueReusableCell(withIdentifier: "TitleTopiceTableViewCell", for: indexPath) as! TitleTopiceTableViewCell
//            cell.askedByLabel.text = messageViewModel.messageModel[indexPath.row].sender
//            cell.questionLabel.text = messageViewModel.messageModel[indexPath.row].sender
//            return cell
//        } else {
            let cell = tableView.dequeueReusableCell(withIdentifier: "MessageTableViewCell", for: indexPath) as! MessageTableViewCell
            cell.label.text = messageViewModel.messageModel[indexPath.row].body
    
            return cell
//        }
    }
    
}
