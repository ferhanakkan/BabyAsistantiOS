//
//  ForumTopics.swift
//  BabyAssistant
//
//  Created by Ferhan Akkan on 24.03.2020.
//  Copyright © 2020 Ferhan Akkan. All rights reserved.
//

import UIKit

final class ForumTopicViewController: BaseViewController {
    
    internal var  tableView: UITableView? = nil
    
    private lazy var forumTopicViewModel = ForumTopicViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .white
        DispatchQueue.main.async {
            self.forumTopicViewModel.setTableView(self)
            self.forumTopicViewModel.getTopics(owner: self)

        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(newTitleButtonPressed))
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
        let vc = MessageViewController()
        AppManager.shared.selectedForumTopic = forumTopicViewModel.topicsModel[indexPath.row].title
        vc.hidesBottomBarWhenPushed = true
        navigationController?.show(vc, sender: nil)
        
    }
    
    @objc private func newTitleButtonPressed() {
        let vc = NewTopicViewController()
        vc.modalPresentationStyle = .overFullScreen
        present(vc,animated: true)
    }
}
