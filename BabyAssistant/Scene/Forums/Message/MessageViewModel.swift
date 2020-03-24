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
            make.leading.trailing.equalToSuperview()
            make.top.equalToSuperview().offset(AppManager.shared.safeAreaTopInset+32)
            make.bottom.equalToSuperview()
        }
        
        owner.tableView!.dataSource = owner
        owner.tableView!.delegate = owner
        
        owner.tableView!.register(UINib(nibName: "TitleTopiceTableViewCell", bundle: nil), forCellReuseIdentifier: "TitleTopiceTableViewCell")
        owner.tableView!.register(UINib(nibName: "MessageTableViewCell", bundle: nil), forCellReuseIdentifier: "MessageTableViewCell")

    }
    
    internal func getMessage(owner: MessageViewController) {
        firebaseDatabase.getSelectedTopicMessage() { (data) in
            self.messageModel = data
            owner.tableView?.reloadData()
        }
    }

    
}
