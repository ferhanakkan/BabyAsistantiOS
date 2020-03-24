//
//  MessageViewModel.swift
//  BabyAssistant
//
//  Created by Ferhan Akkan on 24.03.2020.
//  Copyright © 2020 Ferhan Akkan. All rights reserved.
//

import SnapKit
import UIKit

class MessageViewModel {
        
    private lazy var firebaseDatabase = FirebaseDatabase()
    
    lazy var messageModel: [MessageModel] = []
    
    internal func setTableView(_ owner: MessageViewController) {
        owner.tableView = UITableView()
        owner.view.addSubview(owner.tableView!)
        owner.tableView!.snp.makeConstraints { (make) in
            make.leading.equalToSuperview().offset(5)
            make.trailing.equalToSuperview().offset(-5)
            make.top.equalToSuperview().offset(AppManager.shared.safeAreaTopInset+32)
            make.bottom.equalToSuperview().offset(-65)
        }
        
        owner.tableView!.dataSource = owner
        owner.tableView!.delegate = owner
        
        owner.tableView!.backgroundColor = .white
        owner.tableView!.separatorColor = .clear
        
        owner.tableView!.register(UINib(nibName: "TitleTopiceTableViewCell", bundle: nil), forCellReuseIdentifier: "TitleTopiceTableViewCell")
        owner.tableView!.register(UINib(nibName: "MessageTableViewCell", bundle: nil), forCellReuseIdentifier: "MessageTableViewCell")

    }

    internal func setSenderView(owner: MessageViewController) {
        let view = UIView()
        view.backgroundColor = .backgroundGreen
        owner.view.addSubview(view)
        
        view.snp.makeConstraints { (make) in
            make.leading.trailing.bottom.equalToSuperview()
            make.height.equalTo(65)
        }
        
        owner.sendButton = UIButton()
        view.addSubview(owner.sendButton!)
        owner.sendButton?.setImage(UIImage(named: "eye"), for: .normal)
        owner.sendButton!.isUserInteractionEnabled = true
        
        owner.sendButton?.snp.makeConstraints({ (make) in
            make.height.width.equalTo(30)
            make.centerY.equalToSuperview()
            make.trailing.equalToSuperview().offset(-20)
            
        })
        
        owner.messageTextfield = UITextField()
        view.addSubview(owner.messageTextfield!)
        owner.messageTextfield?.placeholder = "Type Message"
        owner.messageTextfield!.borderStyle = .roundedRect
        
        owner.messageTextfield?.snp.makeConstraints({ (make) in
            make.leading.equalToSuperview().offset(20)
            make.trailing.equalTo((owner.sendButton?.snp.leading)!).offset(-20)
            make.bottom.equalToSuperview().offset(-5)
            make.top.equalToSuperview().offset(5)
        })
    }
    
    internal func getMessage(owner: MessageViewController) {
        firebaseDatabase.getSelectedTopicMessage() { (data) in
            self.messageModel = data
            owner.tableView?.reloadData()
        }
    }
    
    func sendMessage(owner: MessageViewController) {
        if !(owner.messageTextfield?.text!.isEmpty)! {
            firebaseDatabase.sendMessageToTopic(message: (owner.messageTextfield!.text!))
            owner.messageTextfield?.text = ""
        }
    }

}
