//
//  NavigationBar.swift
//  BabyAssistant
//
//  Created by Ferhan Akkan on 16.03.2020.
//  Copyright © 2020 Ferhan Akkan. All rights reserved.
//

import UIKit
import Firebase

class NavigationBar {
    
    class func createNavigatonController(owner: Any) -> UINavigationController{
//        let currentUser = Auth.auth().currentUser
//        if let rememberMe = UserDefaults.standard.value(forKey: "rememberMe") as? Bool {
//            if currentUser != nil && rememberMe {
////                return Tabbar.createTabBarWithNavigationBar(owner: owner)
//                return NavigationBar.navigationBarSplash()
//            } else {
//                return  NavigationBar.navigationBarSplash()
//            }
//        } else {
            return NavigationBar.navigationBarSplash()
        
    }

    class func navigationBarSplash() -> UINavigationController {
        let navigationController = UINavigationController()
        navigationController.navigationBar.isTranslucent = false
        navigationController.navigationBar.barTintColor = UIColor.backgroundGreen
        navigationController.navigationBar.titleTextAttributes = [.foregroundColor: UIColor.white]
        navigationController.navigationBar.tintColor = .white
        navigationController.navigationBar.barStyle = .black
        
        
        let appStartPoint = UIStoryboard.auth.instantiateViewController(withIdentifier: "SplashViewController") as! SplashViewController
//        let appStartPoint = NewTopicViewController()
        
        navigationController.setViewControllers([appStartPoint], animated: true)
        return navigationController
    }
    
}
