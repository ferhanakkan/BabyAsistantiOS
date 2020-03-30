//
//  ExploreDetailViewModel.swift
//  BabyAssistant
//
//  Created by Ferhan Akkan on 27.03.2020.
//  Copyright © 2020 Ferhan Akkan. All rights reserved.
//

import UIKit
import SnapKit

final class ExploreDetailViewModel {
    
    lazy var titleData:ExploreModel? = nil
    lazy var exploreDetailArray:[ExploreDetailModel]? = nil
    lazy var firebase = FirebaseDatabase()
    
    //MARK: - Setup UI
    
    internal func setUI(_ owner: ExploreDetailViewController) {
        setViewController(owner)
        setCollectionView(owner)
        
    }
    
    internal func setViewController(_ owner: ExploreDetailViewController) {
        owner.view.backgroundColor = .white
    }
    
    internal func setCollectionView(_ owner: ExploreDetailViewController) {
        let collectionView: UICollectionView = {
                let layout = UICollectionViewFlowLayout()
//                layout.estimatedItemSize = UICollectionViewFlowLayout.automaticSize
                layout.scrollDirection = .vertical
            layout.itemSize = CGSize(width: owner.view.frame.width, height: 200) // make it self size !!!!
                let collectionview = UICollectionView(frame: CGRect(x: 0, y: 0, width: 0, height: 0 ), collectionViewLayout: layout)
                collectionview.backgroundColor = .clear
                return collectionview
            }()
        
        owner.collectionView = collectionView
        owner.view.addSubview(owner.collectionView!)
        owner.collectionView?.isUserInteractionEnabled = false
        
        owner.collectionView!.snp.makeConstraints { (make) in
            make.leading.trailing.equalToSuperview()
            make.top.equalToSuperview().offset(AppManager.shared.safeAreaTopInset+32)
            make.bottom.equalToSuperview().offset(AppManager.shared.safeAreaBottomInset-32)
        }
        
        owner.collectionView?.delegate = owner
        owner.collectionView?.dataSource = owner
        owner.collectionView?.register(ExploreDetailCollectionViewCell.self, forCellWithReuseIdentifier: "ExploreDetailCollectionViewCell")
        owner.collectionView?.register(ExploreDetailTitleCollectionViewCell.self, forCellWithReuseIdentifier: "ExploreDetailTitleCollectionViewCell")
        
    }
    
    
    internal func fetchData(title:String, completion: @escaping(Bool)->Void) {
        firebase.getExploreDetails(title: title) { (data) in
            self.exploreDetailArray = data
            completion(true)
        }
    }
    
}


