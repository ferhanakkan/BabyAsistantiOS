//
//  SplashViewController.swift
//  BabyAssistant
//
//  Created by Ferhan Akkan on 17.03.2020.
//  Copyright © 2020 Ferhan Akkan. All rights reserved.
//

import UIKit
import SnapKit

final class SplashViewController: UIViewController , CollectionViewIndexPicker {
    
    private let splashViewModel = SplashViewModel()
    
    internal lazy var imageView:UIImageView? = nil
    
    internal var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.estimatedItemSize = UICollectionViewFlowLayout.automaticSize
        layout.scrollDirection = .horizontal
//        layout.itemSize = CGSize(width: 300, height: 380) // make it self size !!!!
        let collectionview = UICollectionView(frame: CGRect(x: 0, y: 0, width: 0, height: 0 ), collectionViewLayout: layout)
        collectionview.backgroundColor = .clear
        return collectionview
    }()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        DispatchQueue.main.async {
            self.splashViewModel.setGreenView(owner: self)
            self.splashViewModel.setImage(self)
            self.splashViewModel.setCollectionView(owner: self)
            self.splashViewModel.collectionViewSetup(owner: self)
        }
    }
    
    
}

//MARK: - CollectionView Setting

extension SplashViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 10
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 3
        
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        splashViewModel.collectionViewCell(indexPath: indexPath, owner: self)
    }
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        splashViewModel.collectionViewScroolEndEditing(self)
    }
    
    func selectedCollectionViewRoad(row: Int) {
        splashViewModel.collectionViewSetShowCell(row: row, owner: self)
    }
}

// MARK: - UICollectionViewDelegateFlowLayout
//extension  SplashViewController {
//
//    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
//        return splashViewModel.setCollectionViewCellFlow(self)
//    }
//}
