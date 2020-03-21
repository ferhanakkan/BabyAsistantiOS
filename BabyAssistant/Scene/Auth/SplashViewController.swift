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

extension SplashViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 30
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 1
        
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = UICollectionViewCell()
        //            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "HowToCollectionViewCell", for: indexPath) as! HowToCollectionViewCell
        //            cell.descriptionLabel.text = datas[indexPath.row].description
        //            cell.titleLabel.text = datas[indexPath.row].title
        //            cell.imageView.image = UIImage(named: datas[indexPath.row].image)
        //    //        cell.backgroundColor = indexPath.item % 2 == 0 ? .red : .green
        //            cell.backgroundColor = .gray
        return cell
    }
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        splashViewModel.collectionViewScroolEndEditing(self)
    }
}
