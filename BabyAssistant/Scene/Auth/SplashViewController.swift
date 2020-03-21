//
//  SplashViewController.swift
//  BabyAssistant
//
//  Created by Ferhan Akkan on 17.03.2020.
//  Copyright © 2020 Ferhan Akkan. All rights reserved.
//

import UIKit
import SnapKit

final class SplashViewController: UIViewController {
    
    private let splashViewModel = SplashViewModel()
    
    internal var collectionView: UICollectionView = {
        let layout = UICollectionViewLayout()
        let collectionview = UICollectionView(frame: CGRect(x: 0, y: 0, width: 0, height: 0 ), collectionViewLayout: layout)
        collectionview.backgroundColor = .red
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
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 3
        
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        print("test")
        switch indexPath.row {
        case 0:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ResetPasswordCollectionViewCell", for: indexPath) as! ResetPasswordCollectionViewCell
            print("0 cell")
            return cell
        case 1:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "RegisterCollectionViewCell", for: indexPath) as! RegisterCollectionViewCell
            print("10 cell")
            return cell
        case 2:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "LogInCollectionViewCell", for: indexPath) as! LogInCollectionViewCell
            return cell
        default:
            let cell = UICollectionViewCell()
            return cell
        }
    }
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        splashViewModel.collectionViewScroolEndEditing(self)
    }
}
