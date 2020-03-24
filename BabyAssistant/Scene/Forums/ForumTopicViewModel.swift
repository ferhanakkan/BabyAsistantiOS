//
//  ForumTopicViewModel.swift
//  BabyAssistant
//
//  Created by Ferhan Akkan on 24.03.2020.
//  Copyright © 2020 Ferhan Akkan. All rights reserved.
//

import SnapKit
import UIKit

class ForumTopicViewModel {
        
    private lazy var firebaseDatabase = FirebaseDatabase()
    
    lazy var topicsModel: [TopicsModel] = []
    
    internal func setTableView(_ owner: ForumTopicViewController) {
        owner.tableView = UITableView()
        owner.view.addSubview(owner.tableView!)
        owner.tableView!.snp.makeConstraints { (make) in
            make.leading.trailing.equalToSuperview()
            make.top.equalToSuperview().offset(AppManager.shared.safeAreaTopInset+32)
            make.bottom.equalToSuperview().offset(AppManager.shared.safeAreaBottomInset-32)
        }
        
        owner.tableView!.dataSource = owner
        owner.tableView!.delegate = owner
        
        owner.tableView!.register(UINib(nibName: "ForumTableViewCell", bundle: nil), forCellReuseIdentifier: "ForumTableViewCell")

    }
    
    internal func getTopics(owner: ForumTopicViewController) {
        firebaseDatabase.getTopics { (data) in
            self.topicsModel = data
            owner.tableView?.reloadData()
        }
    }

    
}
