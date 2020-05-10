//
//  ExploreViewController.swift
//  BabyAssistant
//
//  Created by Ferhan Akkan on 27.03.2020.
//  Copyright © 2020 Ferhan Akkan. All rights reserved.
//

import UIKit

final class ExploreViewController : BaseViewController {
    
    let exploreViewModel = ExploreViewModel()
    
    internal var collectionView: UICollectionView? = nil     
    override func viewDidLoad() {
        super.viewDidLoad()
        exploreViewModel.setUI(self)
        AppManager.shared.showLoading(collectionView!)
        exploreViewModel.fetchData { (_) in
            self.collectionView?.reloadData()
            AppManager.shared.hideLoading(self.collectionView!)
        }
    }
    
}

extension ExploreViewController:  UICollectionViewDelegate ,UICollectionViewDataSource  {
    
//    func collectionSkeletonView(_ skeletonView: UICollectionView, cellIdentifierForItemAt indexPath: IndexPath) -> ReusableCellIdentifier {
//        return "ExploreCollectionViewCell"
//    }
    
    func collectionSkeletonView(_ skeletonView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 4
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return exploreViewModel.exploreArray.count
     }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ExploreCollectionViewCell", for: indexPath) as! ExploreCollectionViewCell
//        AppManager.shared.showLoading(cell.image)
        
        DispatchQueue.main.async {
            cell.image.kf.setImage(with: self.exploreViewModel.exploreArray[indexPath.row].image)
            cell.title.text = self.exploreViewModel.exploreArray[indexPath.row].title
            cell.subTitle.text = self.exploreViewModel.exploreArray[indexPath.row].subtitle
        }
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        collectionView.deselectItem(at: indexPath, animated: true)
        let vc = ExploreDetailViewController()
        vc.hidesBottomBarWhenPushed = true
        vc.exploreDetailViewModel.titleData = exploreViewModel.exploreArray[indexPath.row]
        navigationController?.show(vc, sender: nil)
    }
    
    
}
