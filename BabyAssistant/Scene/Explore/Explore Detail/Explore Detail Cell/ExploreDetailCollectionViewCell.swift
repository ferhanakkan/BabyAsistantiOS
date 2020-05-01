//
//  ExploreDetailCell.swift
//  BabyAssistant
//
//  Created by Ferhan Akkan on 27.03.2020.
//  Copyright © 2020 Ferhan Akkan. All rights reserved.
//


import UIKit
import SnapKit

final class ExploreDetailCollectionViewCell: UICollectionViewCell {
    
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
        title.textAlignment = .center
        title.font = UIFont.systemFont(ofSize: 15)
        title.textColor = .black
        title.text = "Test Yazisi"
        return title
    }()
    


    override init(frame: CGRect) {
        super.init(frame: .zero)
        contentView.addSubview(image)
        contentView.addSubview(title)
        
        image.snp.makeConstraints { (make) in
            make.top.leading.equalToSuperview().offset(30)
            make.trailing.equalToSuperview().offset(-30)
        }
        
        title.snp.makeConstraints { (make) in
            make.leading.equalToSuperview().offset(30)
            make.trailing.bottom.equalToSuperview().offset(-30)
            make.top.equalTo(image.snp.bottom).offset(30)
        }
        
    }
    
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
