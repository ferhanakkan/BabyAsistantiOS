//
//  ForumTopics.swift
//  BabyAssistant
//
//  Created by Ferhan Akkan on 24.03.2020.
//  Copyright © 2020 Ferhan Akkan. All rights reserved.
//

import UIKit

final class ForumTopicViewController: UIViewController {
    
    internal var  tableView: UITableView? = nil
    
    private lazy var forumTopicViewModel = ForumTopicViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        forumTopicViewModel.setTableView(self)
        forumTopicViewModel.getTopics(owner: self)
    }
    
}

//MARK: - Table View Delegate & DataSource

extension ForumTopicViewController: UITableViewDataSource , UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return forumTopicViewModel.topicsModel.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
         let cell = tableView.dequeueReusableCell(withIdentifier: "ForumTableViewCell", for: indexPath) as! ForumTableViewCell
        cell.titleLabel.text = forumTopicViewModel.topicsModel[indexPath.row].title
        cell.subTitleLabel.text = forumTopicViewModel.topicsModel[indexPath.row].subTitle
        cell.accessoryType = .disclosureIndicator

        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        if let vc = UIStoryboard.forum.instantiateViewController(withIdentifier: "MessageViewController") as? MessageViewController {
            AppManager.shared.selectedForumTopic = forumTopicViewModel.topicsModel[indexPath.row].title
            navigationController?.show(vc, sender: nil)
        }
    }
}
