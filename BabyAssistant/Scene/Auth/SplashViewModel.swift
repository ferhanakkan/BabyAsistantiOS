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
    
    //MARK: - Set UI
    
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
        owner.collectionView.showsVerticalScrollIndicator = false
        owner.collectionView.showsHorizontalScrollIndicator = false
        owner.collectionView.isScrollEnabled = false
        owner.collectionView.snp.makeConstraints { (make) in
            make.leading.equalToSuperview().offset(20)
            make.top.equalTo(owner.imageView!.snp.bottom).offset(20)
            make.trailing.equalToSuperview().offset(-20)
            make.bottom.equalToSuperview().offset(-20)
 
        }
    }
        
    internal func setImage(_ owner: SplashViewController) {

        let myImageView:UIImageView = UIImageView()
        myImageView.contentMode = .scaleAspectFit
        myImageView.image = UIImage(named: "babylogo.jpg")!
        
        owner.imageView = myImageView
        owner.view.addSubview(owner.imageView!)
        
        owner.imageView!.snp.makeConstraints { (make) in
            make.width.equalTo(100)
            make.height.equalTo(100)
            make.centerX.equalToSuperview()
            make.top.equalToSuperview().offset(20)
        }
    }
    
    //MARK: - Collection View Logic's
    
    
    internal func collectionViewSetup(owner: SplashViewController) {
        owner.collectionView.delegate = owner
        owner.collectionView.dataSource = owner
        owner.collectionView.register(UINib(nibName: "RegisterCollectionViewCell", bundle: .main), forCellWithReuseIdentifier: "RegisterCollectionViewCell")
        owner.collectionView.register(UINib(nibName: "LogInCollectionViewCell", bundle: .main), forCellWithReuseIdentifier: "LogInCollectionViewCell")
        owner.collectionView.register(UINib(nibName: "ResetPasswordCollectionViewCell", bundle: .main), forCellWithReuseIdentifier: "ResetPasswordCollectionViewCell")
        owner.collectionView.isPagingEnabled = true
        collectionViewSetShowCell(row: 1, owner: owner)
    }
    
    internal func collectionViewScroolEndEditing(_ owner : SplashViewController) {
        for cell in owner.collectionView.visibleCells {
            if let row = owner.collectionView.indexPath(for: cell)?.item {
                let index = IndexPath(row: row, section: 0)
                owner.collectionView.scrollToItem(at: index, at: .centeredHorizontally, animated: true)
            }
        }
    }
    
    internal func collectionViewSetShowCell(row: Int , owner: SplashViewController) {
        let index = IndexPath(row: row, section: 0)
        owner.collectionView.scrollToItem(at: index, at: .centeredHorizontally, animated: true)
    }
    
    internal func collectionViewCell(indexPath: IndexPath, owner: SplashViewController) -> UICollectionViewCell{
        switch indexPath.row {
        case 2:
            let cell = owner.collectionView.dequeueReusableCell(withReuseIdentifier: "ResetPasswordCollectionViewCell", for: indexPath) as! ResetPasswordCollectionViewCell
            cell.delegate = owner
            return cell
        case 0:
            let cell = owner.collectionView.dequeueReusableCell(withReuseIdentifier: "RegisterCollectionViewCell", for: indexPath) as! RegisterCollectionViewCell
            
            cell.delegate = owner
            return cell
        case 1:
            let cell = owner.collectionView.dequeueReusableCell(withReuseIdentifier: "LogInCollectionViewCell", for: indexPath) as! LogInCollectionViewCell
            cell.delegate = owner
            return cell
        default:
            let cell = UICollectionViewCell()
            return cell
        }
    }
//    
//    func setCollectionViewCellFlow(_ owner: SplashViewController) -> CGSize {
//            let availableWidth = owner.collectionView.frame.width
//            let sectionInset: CGFloat = 20.0
//            let cellSpacing: CGFloat = 15.0
//            let cellWidth = (availableWidth - sectionInset * 2 - cellSpacing) / 1
//            let cellSize = CGSize(width: cellWidth.rounded(.down), height: 300)
//            return cellSize
//    }
}
