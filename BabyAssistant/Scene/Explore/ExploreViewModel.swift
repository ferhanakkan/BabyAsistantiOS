//
//  ExpploreViewModel.swift
//  BabyAssistant
//
//  Created by Ferhan Akkan on 27.03.2020.
//  Copyright © 2020 Ferhan Akkan. All rights reserved.
//

import UIKit
import SnapKit
import Firebase

final class ExploreViewModel {
    
    let firebase = FirebaseDatabase()
    
    lazy var exploreArray: [ExploreModel] = []
    
    //MARK: - Setup UI
    
    internal func setUI(_ owner: ExploreViewController) {
        setViewController(owner)
        setCollectionView(owner)
        
    }
    
    internal func setViewController(_ owner: ExploreViewController) {
        owner.view.backgroundColor = .white
    }
    
    internal func setCollectionView(_ owner: ExploreViewController) {
        let collectionView: UICollectionView = {
                let layout = UICollectionViewFlowLayout()
//                layout.estimatedItemSize = UICollectionViewFlowLayout.automaticSize
                layout.scrollDirection = .vertical
            layout.itemSize = CGSize(width: owner.view.frame.width*0.9, height: 200) // make it self size !!!!
                let collectionview = UICollectionView(frame: CGRect(x: 0, y: 0, width: 0, height: 0 ), collectionViewLayout: layout)
                collectionview.backgroundColor = .clear
                return collectionview
            }()
        
        owner.collectionView = collectionView
        owner.view.addSubview(owner.collectionView!)
        
        owner.collectionView!.snp.makeConstraints { (make) in
            make.leading.trailing.equalToSuperview()
            make.top.equalToSuperview().offset(AppManager.shared.safeAreaTopInset+32)
            make.bottom.equalToSuperview().offset(AppManager.shared.safeAreaBottomInset-32)
        }
        
        owner.collectionView?.delegate = owner
        owner.collectionView?.dataSource = owner
        owner.collectionView?.register(ExploreCollectionViewCell.self, forCellWithReuseIdentifier: "ExploreCollectionViewCell")
        
    }
    
    internal func fetchData(completion: @escaping(Bool) -> Void) {
        firebase.getExploreTopics { (data) in
            self.exploreArray = data
            completion(true)
        }
        
    }
    
}

