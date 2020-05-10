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
        layout.scrollDirection = .horizontal
        layout.estimatedItemSize = CGSize(width: UIScreen.main.bounds.width*0.9, height: 1)
        let collectionview = UICollectionView(frame: CGRect(x: 0, y: 0, width: 0, height: 0 ), collectionViewLayout: layout)
        collectionview.backgroundColor = .clear
        return collectionview
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        DispatchQueue.main.async {
            self.view.backgroundColor = .white
            self.splashViewModel.setGreenView(owner: self)
            self.splashViewModel.setImage(self)
            self.splashViewModel.setCollectionView(owner: self)
            self.splashViewModel.collectionViewSetup(owner: self)
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(newTitleButtonPressed))
    }

    @objc private func newTitleButtonPressed() {
        let vc = NewTopicViewController()
        vc.modalPresentationStyle = .overFullScreen
        present(vc,animated: true)
    }
}

//MARK: - CollectionView Setting

extension SplashViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 100
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 4
        
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


