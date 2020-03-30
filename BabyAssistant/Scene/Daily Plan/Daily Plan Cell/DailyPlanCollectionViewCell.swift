//
//  DailyPlanCollectionViewCell.swift
//  BabyAssistant
//
//  Created by Ferhan Akkan on 30.03.2020.
//  Copyright © 2020 Ferhan Akkan. All rights reserved.
//

import UIKit
import SnapKit

final class DailyPlanCollectionViewCell: UICollectionViewCell {
    
    let image: UIImageView = {
        let view = UIImageView()
        view.image = UIImage(named: "eye")
        view.contentMode = .scaleToFill
        view.layer.cornerRadius = 15
        return view
    }()
    
    let title: UILabel = {
        let title = UILabel()
        title.numberOfLines = 0
        title.textAlignment = .left
        title.font = UIFont.boldSystemFont(ofSize: 30)
        title.textColor = .white
        title.text = "Test Yazisi"
        
        return title
    }()
    
    let subTitle: UILabel = {
        let title = UILabel()
        title.numberOfLines = 0
        title.textAlignment = .left
        title.font = UIFont.systemFont(ofSize: 15)
        title.textColor = .white
        title.text = "Test Yazisi"
        
        return title
    }()
    
    let time: UILabel = {
        let title = UILabel()
        title.numberOfLines = 0
        title.textAlignment = .left
        title.font = UIFont.boldSystemFont(ofSize: 25)
        title.textColor = .white
        title.text = "Test Yazisi"
        
        return title
    }()

    override init(frame: CGRect) {
        super.init(frame: .zero)
        contentView.cornerRadius = 15
        contentView.addSubview(image)
        image.addSubview(title)
        image.addSubview(subTitle)
        image.addSubview(time)
        
        image.snp.makeConstraints { (make) in
            make.top.bottom.leading.trailing.equalToSuperview()
        }
        
        title.snp.makeConstraints { (make) in
            make.height.equalTo(20)
            make.trailing.equalToSuperview().offset(15)
            make.leading.equalToSuperview().offset(15)
            make.bottom.equalTo(subTitle.snp.top).offset(-7)
        }
        
        subTitle.snp.makeConstraints { (make) in
            make.height.equalTo(20)
            make.trailing.equalToSuperview().offset(15)
            make.leading.equalToSuperview().offset(15)
            make.bottom.equalToSuperview().offset(-20)
        }
        
        time.snp.makeConstraints { (make) in
            make.height.equalTo(50)
            make.top.equalToSuperview().offset(15)
            make.trailing.equalToSuperview().offset(-15)
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
