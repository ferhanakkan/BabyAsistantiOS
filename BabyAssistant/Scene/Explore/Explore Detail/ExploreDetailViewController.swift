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
    }
    
}

extension ExploreDetailViewController: UICollectionViewDelegate ,UICollectionViewDataSource  {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
         return 4
     }
     
     func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        switch indexPath.row {
        case 0:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ExploreDetailTitleCollectionViewCell", for: indexPath) as! ExploreDetailTitleCollectionViewCell
            return cell
        default:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ExploreDetailCollectionViewCell", for: indexPath) as! ExploreDetailCollectionViewCell
            return cell
        }
     }
}

