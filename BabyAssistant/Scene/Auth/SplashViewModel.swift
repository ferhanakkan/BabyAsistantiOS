//
//  SplashViewModel.swift
//  BabyAssistant
//
//  Created by Ferhan Akkan on 20.03.2020.
//  Copyright © 2020 Ferhan Akkan. All rights reserved.
//

import UIKit
import SnapKit

struct SplashViewModel {
    
    internal func setGreenView(owner: SplashViewController) {
        
        let greenView = UIView()
        greenView.backgroundColor = .backgroundGreen
        owner.view.addSubview(greenView)
        greenView.roundCornersEachCorner([.bottomLeft,.bottomRight], radius: 30)
        greenView.snp.makeConstraints { (make) in
            make.top.left.right.equalTo(0)
            make.height.equalTo(owner.view.frame.height*0.3)
            make.width.equalTo(owner.view.frame.width)
        }
        
    }
    
    internal func setCollectionView(owner: SplashViewController) {
        owner.view.addSubview(owner.collectionView)
        owner.collectionView.shadowAndCorner(radius: 15, shadowRadius: 7, opacity: 0.6, color: .black, width: 5, height: 5)
        owner.collectionView.snp.makeConstraints { (make) in
            make.height.equalTo(owner.view.frame.height*0.6)
            make.width.equalTo(owner.view.frame.width*0.8)
//            make.center.centerX.equalTo(owner.view.center.x)
            make.topMargin.equalTo(170)
            make.centerX.equalTo(owner.view.center.x)
        }
    }
        
    internal func setImage(_ owner: SplashViewController) {
        let view = UIView()
        view.backgroundColor = .white
        let image = UIImage(named: "babylogo.jpg")!
        
        let myImageView:UIImageView = UIImageView()
        myImageView.contentMode = UIView.ContentMode.scaleAspectFit
        myImageView.frame.size.width = 100
        myImageView.frame.size.height = 100
        myImageView.center = view.center
        
        myImageView.image = image
        view.addSubview(myImageView)
        
        owner.view.addSubview(view)
        view.snp.makeConstraints { (make) in
            make.center.centerX.equalTo(owner.view.center.x)
            make.topMargin.equalTo(70)
        }
    }
    
    
    internal func collectionViewSetup(owner: SplashViewController) {
        owner.collectionView.delegate = owner
        owner.collectionView.dataSource = owner
        owner.collectionView.register(UINib(nibName: "HowToCollectionViewCell", bundle: .main), forCellWithReuseIdentifier: "HowToCollectionViewCell")
        owner.collectionView.isPagingEnabled = true
    }
    
    internal func collectionViewScroolEndEditing(_ owner : SplashViewController) {
        for cell in owner.collectionView.visibleCells {
            if let row = owner.collectionView.indexPath(for: cell)?.item {
                if row == 0 {
                    owner.collectionView.isScrollEnabled = false
                } else {
                    owner.collectionView.isScrollEnabled = true
                }
            }
        }
    }
}
