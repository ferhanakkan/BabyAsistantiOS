//
//  LanguageViewController.swift
//  BabyAssistant
//
//  Created by Ferhan Akkan on 29.03.2020.
//  Copyright © 2020 Ferhan Akkan. All rights reserved.
//

import UIKit
import SnapKit
import Localize

final class LanguageViewController: UIViewController {
    
    private lazy var tableView: UITableView? = nil
    private let langArray = ["English","Turkish"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .white
        setTableView()
    }
}

extension LanguageViewController: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        langArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
        cell.textLabel?.text = langArray[indexPath.row]
        switch indexPath.row {
        case 0:
            if UserDefaults.standard.value(forKey: "lang") as! String == "en" {
                cell.accessoryType = .checkmark
            }
        case 1:
            if UserDefaults.standard.value(forKey: "lang") as! String == "tr" {
                cell.accessoryType = .checkmark
            }
        default:
            break
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let userDefaults = UserDefaults.standard
        
        switch indexPath.row{
        case 0:
            Localize.update(language: "en")
            userDefaults.set("en", forKey: "lang")
        case 1:
            Localize.update(language: "tr")
            userDefaults.set("tr", forKey: "lang")
        default:
            break
        }
        userDefaults.synchronize()
        
        guard let delegate = UIApplication.shared.delegate else { return }
        guard let window = (delegate as! AppDelegate).window else { return }
        window.rootViewController = Tabbar.createTabBarWithNavigationBar(owner: delegate)
    }
    
    func setTableView() {
        tableView = UITableView()
        self.view.addSubview(tableView!)
        tableView?.snp.makeConstraints({ (make) in
            make.leading.trailing.bottom.equalToSuperview()
            make.top.equalTo(AppManager.shared.safeAreaTopInset)
        })
        
        tableView!.dataSource = self
        tableView!.delegate = self
        tableView!.tableFooterView = UIView(frame: .zero)
        tableView!.backgroundColor = .white
    }
    
}
