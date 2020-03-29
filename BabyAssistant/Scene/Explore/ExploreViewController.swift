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
        exploreViewModel.fetchData { (_) in
            self.collectionView?.reloadData()
        }
    }
    
}

extension ExploreViewController:  UICollectionViewDelegate ,UICollectionViewDataSource  {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return exploreViewModel.exploreArray.count
     }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ExploreCollectionViewCell", for: indexPath) as! ExploreCollectionViewCell
        DispatchQueue.main.async {
            cell.image.kf.setImage(with: self.exploreViewModel.exploreArray[indexPath.row].image)
        }
        cell.title.text = exploreViewModel.exploreArray[indexPath.row].title
        cell.subTitle.text = exploreViewModel.exploreArray[indexPath.row].subtitle
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        collectionView.deselectItem(at: indexPath, animated: true)
        let vc = ExploreDetailViewController()
        vc.exploreDetailViewModel.titleData = exploreViewModel.exploreArray[indexPath.row]
        navigationController?.show(vc, sender: nil)
    }
    
    
}
