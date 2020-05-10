//
//  ExploreDetailViewController.swift
//  BabyAssistant
//
//  Created by Ferhan Akkan on 27.03.2020.
//  Copyright © 2020 Ferhan Akkan. All rights reserved.
//

import UIKit

final class ExploreDetailViewController : UIViewController {
    
    let exploreDetailViewModel = ExploreDetailViewModel()
    
    internal var collectionView: UICollectionView? = nil
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        exploreDetailViewModel.setUI(self)
        exploreDetailViewModel.fetchData(title: exploreDetailViewModel.titleData!.title) { (_) in
            self.collectionView?.reloadData()
        }
    }
    
}

extension ExploreDetailViewController: UICollectionViewDelegate ,UICollectionViewDataSource  {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if let count = exploreDetailViewModel.exploreDetailArray?.count {
            return count+1
        } else {
           return 0
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
                
        if indexPath.row == 0 {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ExploreDetailTitleCollectionViewCell", for: indexPath) as! ExploreDetailTitleCollectionViewCell
            cell.title.text = exploreDetailViewModel.titleData?.title
            DispatchQueue.main.async {
                cell.image.kf.setImage(with: self.exploreDetailViewModel.titleData!.image)
            }
            return cell
            
        } else if exploreDetailViewModel.exploreDetailArray![indexPath.row-1].title == "Video" {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ExploreDetailVideoCollectionViewCell", for: indexPath) as! ExploreDetailVideoCollectionViewCell
            cell.url = exploreDetailViewModel.exploreDetailArray![indexPath.row-1].imageUrl.absoluteString
                return cell
        } else {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ExploreDetailCollectionViewCell", for: indexPath) as! ExploreDetailCollectionViewCell
            cell.title.text = exploreDetailViewModel.exploreDetailArray![indexPath.row-1].title
            DispatchQueue.main.async {
                cell.image.kf.setImage(with: self.exploreDetailViewModel.exploreDetailArray![indexPath.row-1].imageUrl)
            }
            return cell
        }
    }
}
