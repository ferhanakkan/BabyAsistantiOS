////
////  BaseViewController.swift
////  BabyAssistant
////
////  Created by Ferhan Akkan on 16.03.2020.
////  Copyright © 2020 Ferhan Akkan. All rights reserved.
////
//
//
//import UIKit
//import Kingfisher
//
//enum NavigationLeft {
//    case blackBack
//    case whiteBack
//    case titleView(UIView)
//    case close
//    case hidden
//}
//
//enum NavigationTitle {
//    case logo
//    case blackTitle
//    case hidden
//}
//
//enum NavigationRight {
//    case profil
//    case list
//}
//
//enum NavigationBackground {
//    case gray
//    case lightOrange
//    case white
//    case transparent
//}
//
//class BaseViewController: UIViewController {
//
//
//    override func viewDidLoad() {
//        super.viewDidLoad()
//
////        if #available(iOS 13.0, *) {
////            isModalInPresentation = true
////        }
////        self.navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
////        self.navigationController?.navigationBar.shadowImage = UIImage()
////        self.navigationController?.navigationBar.isTranslucent = false
////        self.navigationController?.interactivePopGestureRecognizer?.delegate = self
////        self.navigationController?.interactivePopGestureRecognizer?.isEnabled = false
//    }
//
//    func initialUI(navigationLeft: NavigationLeft,navigationTitle: NavigationTitle,navigationRight: NavigationRight,navigationBackground:NavigationBackground){
//        let navigationBarLeftButton = UIBarButtonItem()
//        let navigationBarRightButton = UIBarButtonItem()
//
//        switch navigationLeft {
//        case .blackBack:
//            navigationBarLeftButton.image = UIImage(named: "backBlack")
//            self.navigationItem.leftBarButtonItem = navigationBarLeftButton
//            self.navigationItem.leftBarButtonItem?.target =  self
//            navigationBarLeftButton.action = #selector(navigationBarBackButtonPressed)
//        case .whiteBack:
//            navigationBarLeftButton.image = UIImage(named: "backWhite")
//            self.navigationItem.leftBarButtonItem = navigationBarLeftButton
//            self.navigationItem.leftBarButtonItem?.target =  self
//            navigationBarLeftButton.action = #selector(navigationBarBackButtonPressed)
//        case .titleView(let view):
//            navigationBarLeftButton.customView = view
//            self.navigationItem.leftBarButtonItem = navigationBarLeftButton
//            self.navigationItem.leftBarButtonItem?.target =  self
//            navigationBarLeftButton.action = #selector(navigationBarBackButtonPressed)
//        case .close:
//            navigationBarLeftButton.image = UIImage(named: "close")
//            self.navigationItem.leftBarButtonItem = navigationBarLeftButton
//            self.navigationItem.leftBarButtonItem?.target =  self
//            navigationBarLeftButton.action = #selector(navigationBarBackButtonPressed)
//        case .hidden:
//            self.navigationItem.leftBarButtonItem = UIBarButtonItem()
//        }
//
//        switch navigationRight {
//        case .profil:
//            let button = UIButton()
//            if let image = App.shared.user?.imageURL {
//                button.kf.setImage(with: URL(string: image),for: .normal,options: [.forceRefresh])
//            } else {
//                button.setImage(UIImage(named: "default-profile"), for: .normal)
//            }
//            button.cornerRadius = 40 / 2
//            button.translatesAutoresizingMaskIntoConstraints = false
//            button.heightAnchor.constraint(equalToConstant: 40).isActive = true
//            button.widthAnchor.constraint(equalToConstant: 40).isActive = true
//            button.addTarget(self, action: #selector(getProfil), for: .touchUpInside)
//            navigationBarRightButton.customView = button
//            button.imageView?.contentMode = .scaleToFill
//            self.navigationItem.rightBarButtonItem = navigationBarRightButton
//        case .searchAndFilter:
//            let navigationBarSecondRightButton = UIBarButtonItem()
//            navigationBarSecondRightButton.image = UIImage(named: "filterIcon")
//            navigationBarRightButton.image = UIImage(named: "searchIcon")
//            navigationBarRightButton.imageInsets = UIEdgeInsets(top: 0, left: 45, bottom: 0, right: 0)
//            navigationBarSecondRightButton.imageInsets = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
//
//            self.navigationItem.rightBarButtonItems = [navigationBarSecondRightButton,navigationBarRightButton]
//            self.navigationItem.rightBarButtonItems![0].target =  self
//            self.navigationItem.rightBarButtonItems![1].target =  self
//
//            navigationBarRightButton.action = #selector(navigationBarRightButtonPressed)
//            navigationBarSecondRightButton.action = #selector(navigationBarSecondRightButtonPressed)
//        case .searchAndMap:
//            let navigationBarSecondRightButton = UIBarButtonItem()
//            navigationBarSecondRightButton.image = UIImage(named: "mapIcon")
//            navigationBarRightButton.image = UIImage(named: "searchIcon")
//            navigationBarRightButton.imageInsets = UIEdgeInsets(top: 0, left: 45, bottom: 0, right: 0)
//            navigationBarSecondRightButton.imageInsets = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
//
//            self.navigationItem.rightBarButtonItems = [navigationBarSecondRightButton,navigationBarRightButton]
//            self.navigationItem.rightBarButtonItems![0].target =  self
//            self.navigationItem.rightBarButtonItems![1].target =  self
//
//            navigationBarRightButton.action = #selector(navigationBarRightButtonPressed)
//            navigationBarSecondRightButton.action = #selector(navigationBarSecondRightButtonPressed)
//        case .map:
//            let navigationBarSecondRightButton = UIBarButtonItem()
//            navigationBarSecondRightButton.image = UIImage(named: "mapIcon")
//            navigationBarSecondRightButton.imageInsets = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
//
//            self.navigationItem.rightBarButtonItems = [navigationBarSecondRightButton]
//            self.navigationItem.rightBarButtonItems![0].target =  self
//            navigationBarSecondRightButton.action = #selector(navigationBarSecondRightButtonPressed)
//        case .searchAndList:
//            let navigationBarSecondRightButton = UIBarButtonItem()
//            navigationBarSecondRightButton.image = UIImage(named: "listIcon")
//            navigationBarRightButton.image = UIImage(named: "searchIcon")
//            navigationBarRightButton.imageInsets = UIEdgeInsets(top: 0, left: 45, bottom: 0, right: 0)
//            navigationBarSecondRightButton.imageInsets = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
//
//            self.navigationItem.rightBarButtonItems = [navigationBarSecondRightButton,navigationBarRightButton]
//            self.navigationItem.rightBarButtonItems![0].target =  self
//            self.navigationItem.rightBarButtonItems![1].target =  self
//
//            navigationBarRightButton.action = #selector(navigationBarRightButtonPressed)
//            navigationBarSecondRightButton.action = #selector(navigationBarSecondRightButtonPressed)
//        case .list:
//            let navigationBarSecondRightButton = UIBarButtonItem()
//            navigationBarSecondRightButton.image = UIImage(named: "listIcon")
//            navigationBarSecondRightButton.imageInsets = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
//
//            self.navigationItem.rightBarButtonItems = [navigationBarSecondRightButton]
//            self.navigationItem.rightBarButtonItems![0].target =  self
//
//            navigationBarSecondRightButton.action = #selector(navigationBarSecondRightButtonPressed)
//        case .likeFavorite(let favoriteStatus):
//            let button = UIButton()
//            if favoriteStatus {
//                button.setImage(UIImage(named: "like"), for: .normal)
//            } else {
//                button.setImage(UIImage(named: "nonLike"), for: .normal)
//            }
//            button.addTarget(self, action: #selector(navigationBarRightButtonPressed), for: .touchUpInside)
//            navigationBarRightButton.customView = button
//            self.navigationItem.rightBarButtonItem = navigationBarRightButton
//
//        case .share(let isBlack):
//            let button = UIButton()
//            if isBlack {
//                button.setImage(UIImage(named: "shareBlackIcon"), for: .normal)
//                button.setTitleColor(.black, for: .normal)
//            } else {
//                button.setImage(UIImage(named: "shareIcon"), for: .normal)
//                button.setTitleColor(.white, for: .normal)
//            }
//            button.setTitle("Share &  Win", for: .normal)
//            button.addTarget(self, action: #selector(navigationBarRightButtonPressed), for: .touchUpInside)
//            button.titleLabel?.font = UIFont.wsSemiBold(ofSize: 15)
//            navigationBarRightButton.customView = button
//            self.navigationItem.rightBarButtonItem = navigationBarRightButton
//
//        case .hidden:
//            self.navigationItem.rightBarButtonItem = nil
//        }
//
//        switch navigationTitle {
//        case .logo:
//            let titleImageView = UIImageView(image: UIImage(named: "logo"))
//            self.navigationItem.titleView = titleImageView
//        case .blackTitle:
//            navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor : UIColor.black,
//                                                                       NSAttributedString.Key.font : UIFont.wsSemiBold(ofSize: 17)]
//        case .hidden:
//            self.navigationItem.titleView = nil
//        }
//
//        switch navigationBackground {
//        case .gray:
//            self.navigationController?.navigationBar.barTintColor = UIColor.gray
//            self.navigationController?.navigationBar.backgroundColor = UIColor.gray
//        case .white:
//            self.navigationController?.navigationBar.barTintColor = UIColor.white
//            self.navigationController?.navigationBar.backgroundColor = UIColor.white
//        case .lightOrange:
//            self.navigationController?.navigationBar.barTintColor = UIColor.orange
//            self.navigationController?.navigationBar.backgroundColor = UIColor.orange
//        case .transparent:
//            self.navigationController?.navigationBar.barTintColor = .clear
//        }
//    }
//
//    @objc open func navigationBarBackButtonPressed(animated: Bool = true){
//        navigationController?.popViewController(animated: true)
//    }
//
//    @objc open func navigationBarRightButtonPressed(animated: Bool = true){
//        navigationController?.popViewController(animated: true)
//    }
//
//    @objc open func navigationBarSecondRightButtonPressed(animated: Bool = true){
//        navigationController?.popViewController(animated: true)
//    }
//
//
////    @objc open func getSettings(animated: Bool = true){
////        self.hidesBottomBarWhenPushed = true
////        navigationController?.pushViewController(UIStoryboard.profile.instantiateViewController(withIdentifier: ProfileSettingsViewController.reuseIdentifier))
////    }
//
//    internal func updateProfilImage(){
//        let navigationBarRightButton = UIBarButtonItem()
//        let button = UIButton()
//        button.cornerRadius = 40 / 2
//        button.translatesAutoresizingMaskIntoConstraints = false
//        button.heightAnchor.constraint(equalToConstant: 40).isActive = true
//        button.widthAnchor.constraint(equalToConstant: 40).isActive = true
//        button.addTarget(self, action: #selector(getProfil), for: .touchUpInside)
//        navigationBarRightButton.customView = button
//        if let image = App.shared.user?.imageURL {
//            Helper.showLoading(button)
//            button.kf.setImage(with: URL(string: image),for: .normal, options: [.forceRefresh]) { result in
//                switch result {
//                case .success( _):
//                    Helper.hideLoading(button)
//                case .failure( _):
//                    button.setImage(UIImage(named: "default-profile"), for: .normal)
//                    Helper.hideLoading(button)
//                }
//            }
//        } else {
//            button.setImage(UIImage(named: "default-profile"), for: .normal)
//        }
//        self.navigationItem.rightBarButtonItem = navigationBarRightButton
//    }
//
//}
