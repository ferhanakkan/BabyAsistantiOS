//
//  MessageViewModel.swift
//  BabyAssistant
//
//  Created by Ferhan Akkan on 24.03.2020.
//  Copyright © 2020 Ferhan Akkan. All rights reserved.
//vb

import SnapKit
import UIKit

class MessageViewModel {
        
    private lazy var firebaseDatabase = FirebaseDatabase()
    
    lazy var messageModel: [MessageModel] = []
    
    internal func setTableView(_ owner: MessageViewController) {
        owner.tableView = UITableView()
        owner.tableView?.isSkeletonable = true
        owner.view.addSubview(owner.tableView!)
        owner.tableView!.snp.makeConstraints { (make) in
            make.leading.equalToSuperview().offset(5)
            make.trailing.equalToSuperview().offset(-5)
            make.top.equalToSuperview().offset(AppManager.shared.safeAreaTopInset+32)
        }
        
        owner.tableView!.dataSource = owner
        owner.tableView!.delegate = owner
        
        owner.tableView!.backgroundColor = .white
        owner.tableView!.separatorColor = .clear
        owner.tableView!.contentInset.bottom = 5
        
        owner.tableView!.register(UINib(nibName: "TitleTopiceTableViewCell", bundle: nil), forCellReuseIdentifier: "TitleTopiceTableViewCell")
        owner.tableView!.register(UINib(nibName: "MessageTableViewCell", bundle: nil), forCellReuseIdentifier: "MessageTableViewCell")

    }

    internal func setSenderView(owner: MessageViewController) {
        let view = UIView()
        view.backgroundColor = .backgroundGreen
        owner.view.addSubview(view)
        
        view.snp.makeConstraints { (make) in
            make.leading.trailing.equalToSuperview()
            make.height.equalTo(65)
            make.top.equalTo(owner.tableView!.snp.bottom)
            make.bottom.equalTo(owner.view.safeAreaLayoutGuide.snp.bottom)
        }
        
        owner.sendButton = UIButton()
        view.addSubview(owner.sendButton!)
        owner.sendButton?.setImage(UIImage(named: "plane"), for: .normal)
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
        
        let viewSafe = UIView()
        viewSafe.backgroundColor = .backgroundGreen
        owner.view.addSubview(viewSafe)
        
        viewSafe.snp.makeConstraints { (make) in
            make.bottom.equalToSuperview()
            make.trailing.leading.equalToSuperview()
            make.top.equalTo(view.snp.bottom)
        }
    }
        
    internal func getMessage(owner: MessageViewController) {
        firebaseDatabase.getSelectedTopicMessage(owner: owner) { (data) in
            self.messageModel = data
        }
    }
    
    func sendMessage(owner: MessageViewController) {
        if !(owner.messageTextfield?.text!.isEmpty)! {
            firebaseDatabase.sendMessageToTopic(message: (owner.messageTextfield!.text!))
            DispatchQueue.main.async {
                owner.messageTextfield?.text = ""
            }
        }
    }
    
    internal func getUserImage(username: String,completion: @escaping(Data) -> Void) {
        firebaseDatabase.getOtherUsersImage(username: username) { (data) in
            completion(data)
        }
    }

}
