//
//  DailyPlanViewController.swift
//  BabyAssistant
//
//  Created by Ferhan Akkan on 30.03.2020.
//  Copyright © 2020 Ferhan Akkan. All rights reserved.
//

import UIKit
import SkeletonView

final class DailyPlanViewController : BaseViewController, DidPlanAdded {
    
    let dailyPlanViewModel = DailyPlanViewModel()
    
    internal var collectionView: UICollectionView? = nil
    
    override func viewDidLoad() {
        super.viewDidLoad()
        dailyPlanViewModel.setUI(self)
        dailyPlanViewModel.fetchData { (_) in
            self.collectionView?.reloadData()
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(newTitleButtonPressed))
    }
    
    @objc private func newTitleButtonPressed() {
        let vc = NewPlanViewController()
        vc.delegate = self
        vc.modalPresentationStyle = .overFullScreen
        present(vc,animated: true)
    }
    
}

extension DailyPlanViewController:  UICollectionViewDelegate ,UICollectionViewDataSource, DidPlanDelete  {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if dailyPlanViewModel.dailyPlanArray.count == 0 {
            return 1
        } else {
            return dailyPlanViewModel.dailyPlanArray.count
        }
     }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        if dailyPlanViewModel.dailyPlanArray.count == 0 {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "DailyPlanNonCollectionViewCell", for: indexPath) as! DailyPlanNonCollectionViewCell
            return cell
        } else {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "DailyPlanCollectionViewCell", for: indexPath) as! DailyPlanCollectionViewCell
            DispatchQueue.main.async {
                cell.image.image = UIImage(data: self.dailyPlanViewModel.dailyPlanArray[indexPath.row].pic!)
                cell.title.text = self.dailyPlanViewModel.dailyPlanArray[indexPath.row].title
                cell.subTitle.text = self.dailyPlanViewModel.dailyPlanArray[indexPath.row].descriptionsss
            }
            cell.date = dailyPlanViewModel.dailyPlanArray[indexPath.row].time
            return cell
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        collectionView.deselectItem(at: indexPath, animated: true)
        if !(dailyPlanViewModel.dailyPlanArray.count == 0) {
            let vc = DailyPlanDetailViewController()
            vc.dailyPlanDetailViewModel.delegate = self
            vc.descriptionLabel.text = dailyPlanViewModel.dailyPlanArray[indexPath.row].descriptionsss
            vc.titleLabel.text = dailyPlanViewModel.dailyPlanArray[indexPath.row].title
            vc.image.image = UIImage(data: dailyPlanViewModel.dailyPlanArray[indexPath.row].pic!)
            vc.dailyPlanDetailViewModel.selectedIndex = indexPath.row
            navigationController?.show(vc, sender: nil)
        }
    }
    
    func planDelete() {
        dailyPlanViewModel.fetchData { (_) in
            self.collectionView?.reloadData()
        }
    }
    
    func planAdded() {
        dailyPlanViewModel.fetchData { (_) in
            self.collectionView?.reloadData()
        }
    }
    
}
