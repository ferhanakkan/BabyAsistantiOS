//
//  DailyPlanViewController.swift
//  BabyAssistant
//
//  Created by Ferhan Akkan on 30.03.2020.
//  Copyright © 2020 Ferhan Akkan. All rights reserved.
//

import UIKit

final class DailyPlanViewController : BaseViewController {
    
    let dailyPlanViewModel = DailyPlanViewModel()
    
    internal var collectionView: UICollectionView? = nil
    
    override func viewDidLoad() {
        super.viewDidLoad()
        dailyPlanViewModel.setUI(self)
        dailyPlanViewModel.fetchData { (_) in
            self.collectionView?.reloadData()
        }
    }
    
}

extension DailyPlanViewController:  UICollectionViewDelegate ,UICollectionViewDataSource  {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return dailyPlanViewModel.dailyPlanArray.count
     }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "DailyPlanCollectionViewCell", for: indexPath) as! DailyPlanCollectionViewCell
        DispatchQueue.main.async {
            cell.image.kf.setImage(with: self.dailyPlanViewModel.dailyPlanArray[indexPath.row].imageUrl)
        }

        cell.time.text = "Time Will Arrive"
        cell.title.text = dailyPlanViewModel.dailyPlanArray[indexPath.row].Title
        cell.subTitle.text = dailyPlanViewModel.dailyPlanArray[indexPath.row].Subtitle
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        collectionView.deselectItem(at: indexPath, animated: true)
    }
    
    
}
