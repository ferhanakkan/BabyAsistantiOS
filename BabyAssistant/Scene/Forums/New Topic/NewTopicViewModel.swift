//
//  NewTopicViewModel.swift
//  BabyAssistant
//
//  Created by Ferhan Akkan on 26.03.2020.
//  Copyright © 2020 Ferhan Akkan. All rights reserved.
//

import UIKit
import BEMCheckBox

struct NewTopicViewModel {
    
    let firebase = FirebaseDatabase()
    
    //MARK: - Setup UI
    internal func setView(owner: NewTopicViewController) {
        setMain(owner: owner)
        setTextfield(owner: owner)
        setButtons(owner: owner)
        setChechBox(owner: owner)
    }
    
    internal func setMain(owner: NewTopicViewController) {
        owner.view.backgroundColor = UIColor.black.withAlphaComponent(0.80)
        owner.view.isOpaque = false
        
        owner.mainSubView = UIView()
        owner.mainSubView?.cornerRadius = 15
        owner.mainSubView?.backgroundColor = .white
        
        owner.view.addSubview(owner.mainSubView!)
        
        owner.mainSubView?.snp.makeConstraints({ (make) in
            make.height.equalTo(owner.view.frame.height*0.6)
            make.width.equalTo(owner.view.frame.width*0.8)
            make.center.equalToSuperview()
        })
    }
    
    internal func setTextfield(owner: NewTopicViewController) {
        owner.titleTextfield = UITextField()
        
        owner.titleTextfield?.borderStyle = .roundedRect
        owner.titleTextfield?.placeholder = "Topic Title"
        
        owner.mainSubView!.addSubview(owner.titleTextfield!)
        owner.titleTextfield?.snp.makeConstraints({ (make) in
            make.leading.top.equalToSuperview().offset(20)
            make.trailing.equalToSuperview().offset(-20)
            make.height.equalTo(50)
        })
        
        owner.subTitleTextfield = UITextField()
        
        owner.subTitleTextfield?.borderStyle = .roundedRect
        owner.subTitleTextfield?.placeholder = "Topic SubTitle"
        
        owner.mainSubView!.addSubview(owner.subTitleTextfield!)
        owner.subTitleTextfield?.snp.makeConstraints({ (make) in
            make.leading.equalToSuperview().offset(20)
            make.trailing.equalToSuperview().offset(-20)
            make.height.equalTo(50)
            make.top.equalTo((owner.titleTextfield?.snp.bottom)!).offset(20)
        })
    }
    
    internal func setButtons(owner: NewTopicViewController) {
        owner.cancelButton = UIButton()
        owner.cancelButton?.setMyButton(title: "Cancel")
        owner.mainSubView?.addSubview(owner.cancelButton!)
        
        owner.cancelButton?.snp.makeConstraints({ (make) in
            make.bottom.trailing.equalToSuperview().offset(-20)
            make.leading.equalToSuperview().offset(20)
            make.height.equalTo(35)
        })
        
        owner.createButton = UIButton()
        owner.createButton?.setMyButton(title: "Create")
        owner.mainSubView?.addSubview(owner.createButton!)
        
        owner.createButton?.snp.makeConstraints({ (make) in
            make.trailing.equalToSuperview().offset(-20)
            make.leading.equalToSuperview().offset(20)
            make.height.equalTo(35)
            make.bottom.equalTo((owner.cancelButton?.snp.top)!).offset(-20)
        })
    }
    
}

//MARK: - ChechBox Setup

extension NewTopicViewModel {
    func setChechBox(owner: NewTopicViewController) {
        
        let title = UILabel()
        title.numberOfLines = 0
        title.text = "Show your name in Topic Creator?"
        owner.mainSubView?.addSubview(title)
        title.snp.makeConstraints { (make) in
            make.top.equalTo((owner.subTitleTextfield?.snp.bottom)!).offset(20)
            make.leading.equalToSuperview().offset(20)
        }
        
        owner.chechBox = BEMCheckBox()
        owner.chechBox?.onTintColor = .green
        owner.chechBox?.onCheckColor = .green
        owner.mainSubView?.addSubview(owner.chechBox!)
        
        owner.chechBox?.snp.makeConstraints({ (make) in
            make.height.width.equalTo(30)
//            make.top.equalTo((owner.subTitleTextfield?.snp.bottom)!).offset(20)
            make.centerY.equalTo(title)
            make.leading.equalTo(title.snp.trailing).offset(20)
            make.trailing.equalToSuperview().offset(-20)
        })
        
    }
    
//     func rememberMeSetter() {
//        if owner.chechBox {
//            UserDefaults.standard.setValue(true, forKey: "rememberMe")
//        } else {
//           UserDefaults.standard.setValue(false, forKey: "rememberMe")
//        }
//    }
}

//MARK: - Button Actions

extension NewTopicViewModel {
    
    func createTopic(owner: NewTopicViewController) {
        if owner.titleTextfield?.text != "" && owner.subTitleTextfield?.text != "" {
            firebase.setTopicTitle(title: owner.titleTextfield!.text!, subtitle: owner.subTitleTextfield!.text!, usernameController: owner.chechBox!.on )
        } else {
            AppManager.shared.messagePresent(title: "OOPS", message: "Please chech title and subtitle can't be empty", type: .error)
        }
    }
    
    func cancelTopic(owner: NewTopicViewController) {
        owner.dismiss(animated: true, completion: nil)
    }
}
