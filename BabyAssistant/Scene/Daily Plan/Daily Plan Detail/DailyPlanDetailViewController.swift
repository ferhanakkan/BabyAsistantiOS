//
//  DailyPlanDetailViewController.swift
//  BabyAssistant
//
//  Created by Ferhan Akkan on 7.05.2020.
//  Copyright © 2020 Ferhan Akkan. All rights reserved.
//

import UIKit
import SnapKit

class DailyPlanDetailViewController : UIViewController {
    
    lazy var contentViewSize = CGSize(width: self.view.frame.width, height: self.view.frame.height+400)
    
    lazy var dailyPlanDetailViewModel = DailyPlanDetailViewModel()

    let scroolView: UIScrollView = {
        let scroll = UIScrollView(frame: .zero)
        scroll.backgroundColor = .white
        return scroll
    }()
    
    let conteiner: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        return view
    }()
    
    let image: UIImageView = {
       let image = UIImageView()
        image.image = UIImage(named: "avatar")
       return image
    }()
    
    let titleLabel: UILabel = {
        let title = UILabel()
        title.font = UIFont.boldSystemFont(ofSize: 25.0)
        title.numberOfLines = 0
        return title
    }()
    
    let descriptionLabel: UILabel = {
        let title = UILabel()
        title.numberOfLines = 0
        return title
    }()
    
//    let endTimeLabel: UILabel = {
//        let title = UILabel()
//        title.numberOfLines = 0
//        return title
//    }()
    
    let deleteButton: UIButton = {
        let button = UIButton()
        button.setMyButton(title: "Delete")
        button.backgroundColor = .red
        button.setTitleColor(.white, for: .normal)
        return button
    }()
    
    
    override func viewDidLoad() {
        scroolView.contentSize = contentViewSize
        view.backgroundColor = .white
        view.addSubview(scroolView)
        scroolView.addSubview(conteiner)
        scroolView.snp.makeConstraints { (make) in
            make.leading.trailing.equalToSuperview()
            make.top.equalTo(self.view.safeAreaLayoutGuide.snp.top)
            make.bottom.equalTo(self.view.safeAreaLayoutGuide.snp.bottom)
        }
        
        conteiner.snp.makeConstraints { (make) in
            make.top.bottom.leading.trailing.equalToSuperview()
            make.width.equalTo(self.view.snp.width)
        }
        
        setImage()
        setTitle()
        setDescription()
//        setTime()
        setButton()
    }
    
    private func setImage() {
        conteiner.addSubview(image)
        
        image.snp.makeConstraints { (make) in
            make.leading.equalToSuperview().offset(20)
            make.trailing.equalToSuperview().inset(20)
            make.top.equalToSuperview().offset(20)
            make.height.equalTo(200)
        }
    }
    
    private func setTitle() {
        conteiner.addSubview(titleLabel)
        
        titleLabel.snp.makeConstraints { (make) in
            make.leading.equalToSuperview().offset(20)
            make.trailing.equalToSuperview().inset(20)
            make.top.equalTo(image.snp.bottom).offset(20)
        }
    }
    
    private func setDescription() {
        conteiner.addSubview(descriptionLabel)
        
        descriptionLabel.snp.makeConstraints { (make) in
            make.leading.equalToSuperview().offset(20)
            make.trailing.equalToSuperview().inset(20)
            make.top.equalTo(titleLabel.snp.bottom).offset(20)
        }
    }
    
//    private func setTime() {
//        conteiner.addSubview(endTimeLabel)
//
//        endTimeLabel.snp.makeConstraints { (make) in
//            make.leading.equalToSuperview().offset(20)
//            make.trailing.equalToSuperview().inset(20)
//            make.top.equalTo(descriptionLabel.snp.bottom).offset(20)
//        }
//    }
    
    private func setButton() {
        conteiner.addSubview(deleteButton)
        
        deleteButton.snp.makeConstraints { (make) in
            make.top.equalTo(self.descriptionLabel.snp.bottom).offset(20)
            make.leading.equalToSuperview().offset(20)
            make.trailing.equalToSuperview().inset(20)
            make.bottom.equalToSuperview().inset(20)
        }
        
        deleteButton.addTarget(self, action: #selector(buttonPressed), for: .touchUpInside)
    }
    
    @objc func buttonPressed() {
        dailyPlanDetailViewModel.deleteSelectedPlanFromDatabase()
        navigationController?.popViewController(animated: true)
    }
}
