//
//  SideBar.swift
//  BabyAssistant
//
//  Created by Ferhan Akkan on 22.03.2020.
//  Copyright © 2020 Ferhan Akkan. All rights reserved.
//

import Foundation
import UIKit
import Firebase
import Kingfisher
import SnapKit

protocol SidebarViewDelegate: class {
    func sidebarDidSelectRow(row: Row)
}

enum Row: String {
    case editProfile
    case settings
    case rate
    case babyNames
    case donate
    case signOut
    case none
    
    init(row: Int) {
        switch row {
        case 0: self = .editProfile
        case 1: self = .settings
        case 2: self = .rate
        case 3: self = .babyNames
        case 4: self = .donate
        case 5: self = .signOut
        default: self = .none
        }
    }
}

class SidebarView: UIView, UITableViewDelegate, UITableViewDataSource {

    var titleArr = [String]()
    
    weak var delegate: SidebarViewDelegate?

    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = .backgroundGreen
        self.clipsToBounds=true
        
        titleArr = ["\(Auth.auth().currentUser?.displayName! ?? "Profile")","Settings","Rate Us", "Baby Names (Upcoming)","Donate", "Sign Out"]
        
        setupViews()
        
        myTableView.delegate=self
        myTableView.dataSource=self
        myTableView.register(UITableViewCell.self, forCellReuseIdentifier: "Cell")
        myTableView.tableFooterView=UIView()
        myTableView.allowsSelection = true
        myTableView.bounces=false
        myTableView.showsVerticalScrollIndicator=false
        myTableView.backgroundColor = UIColor.clear
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if Auth.auth().currentUser != nil {
            return titleArr.count
        } else {
            return titleArr.count-1
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell=tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        cell.backgroundColor = .clear
        cell.selectionStyle = .none
        if indexPath.row == 0 {
            cell.backgroundColor = .backgroundGreen
            let cellImg: UIImageView!
            cellImg = UIImageView(frame: CGRect(x: 15, y: 10, width: 80, height: 80))
            cellImg.layer.borderWidth = 2
            cellImg.layer.borderColor = UIColor.gray.cgColor
            cellImg.clipsToBounds = true
            cellImg.layer.cornerRadius = 40
            cellImg.contentMode = .scaleAspectFill
            cellImg.layer.masksToBounds=true
            DispatchQueue.main.async {
               if let data = UserDefaults.standard.value(forKey: "profileImage") as? Data{
                cellImg.image = UIImage(data: data)
                } else {
                    cellImg.image = UIImage(named: "avatar")
                }
            }

            cell.addSubview(cellImg)

            let cellLbl = UILabel(frame: CGRect(x: 110, y: cell.frame.height/2-15, width: 250, height: 30))
            cell.addSubview(cellLbl)
            cellLbl.text = titleArr[indexPath.row]
            cellLbl.font=UIFont.systemFont(ofSize: 17)
            cellLbl.textColor=UIColor.gray
        } else {            
            cell.textLabel?.text=titleArr[indexPath.row]
            cell.textLabel?.textColor=UIColor.gray
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.delegate?.sidebarDidSelectRow(row: Row(row: indexPath.row))
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.row == 0 {
            return 100
        } else {
            return 60
        }
    }
    
    func setupViews() {
        self.addSubview(myTableView)
        myTableView.topAnchor.constraint(equalTo: topAnchor).isActive=true
        myTableView.leftAnchor.constraint(equalTo: leftAnchor).isActive=true
        myTableView.rightAnchor.constraint(equalTo: rightAnchor).isActive=true
        myTableView.bottomAnchor.constraint(equalTo: bottomAnchor).isActive=true
    }
    
    let myTableView: UITableView = {
        let table=UITableView()
        table.translatesAutoresizingMaskIntoConstraints=false
        return table
    }()
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}


