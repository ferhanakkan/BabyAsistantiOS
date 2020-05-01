//
//  AppManager.swift
//  BabyAssistant
//
//  Created by Ferhan Akkan on 16.03.2020.
//  Copyright © 2020 Ferhan Akkan. All rights reserved.
//
import UIKit
import SkeletonView

struct AppManager {
    
    static var shared = AppManager()
    
    var selectedForumTopic:String?
    var profileImageUrl:URL?
    
    let reachability: Reachability = try! Reachability(hostname: "google.com")

    func setReachability() {
        do {
            try reachability.startNotifier()
        } catch {
            assertionFailure("Unable to start\nnotifier")
        }

        reachability.whenUnreachable = { reachability in
            self.messagePresent(title: "OOOPS!!!", message: "Internet connection has been lost. Try again", type: .error)
        }
    }
    
    func messagePresent(title: String, message: String, type: ImageType) {
        if let vc = Bundle.main.loadNibNamed("ErrorSuccessViewController", owner: UIApplication.getPresentedViewController()!, options: nil)?.first as? ErrorSuccessViewController {
            vc.imageTypeSelector = type
            vc.titleLabel.text = title
            vc.messageLabel.text = message
            vc.modalPresentationStyle = .overFullScreen
            
            UIApplication.getPresentedViewController()!.present(vc, animated: true)
        }
    }
    
    public var safeAreaTopInset: CGFloat {
        if #available(iOS 11.0, *) {
            return UIApplication.shared.keyWindow?.safeAreaInsets.top ?? 0
        } else {
            return 0
        }
    }
    
    public var safeAreaBottomInset: CGFloat {
        if #available(iOS 11.0, *) {
            return UIApplication.shared.keyWindow?.safeAreaInsets.bottom ?? 0
        } else {
            return 0
        }
    }
    
     func showLoading(_ collectionView: UICollectionView){
        collectionView.isSkeletonable = true
        let gradient = SkeletonGradient(baseColor: UIColor.clouds)
        let animation = SkeletonAnimationBuilder().makeSlidingAnimation(withDirection: .topLeftBottomRight)
        collectionView.showAnimatedGradientSkeleton(usingGradient: gradient, animation: animation, transition: .none)
    }
    
     func hideLoading(_ collectionView: UICollectionView){
        UIView.animate(withDuration: 0.1,delay: 0.0 ,options: .curveEaseIn, animations: {
            collectionView.alpha = 1.0
        })
        collectionView.hideSkeleton(reloadDataAfter: true, transition: .crossDissolve(0.5))
    }
    
     func hideLoading(_ imageView: UIImageView){
        imageView.hideSkeleton(reloadDataAfter: true, transition: .crossDissolve(0.5))
    }
    
     func showLoading(_ imageView: UIImageView){
        imageView.isSkeletonable = true
        let gradient = SkeletonGradient(baseColor: UIColor.clouds)
        let animation = SkeletonAnimationBuilder().makeSlidingAnimation(withDirection: .topLeftBottomRight)
        imageView.showAnimatedGradientSkeleton(usingGradient: gradient, animation: animation, transition: .none)
    }
}
