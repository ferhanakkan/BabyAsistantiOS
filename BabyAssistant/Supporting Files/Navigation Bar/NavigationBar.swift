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
        let currentUser = Auth.auth().currentUser
        print("ferro\(currentUser)")
        if currentUser == nil {
            
            let navigationController = UINavigationController()
            navigationController.navigationBar.isTranslucent = false
            navigationController.navigationBar.barTintColor = UIColor.lightOrange
            navigationController.navigationBar.titleTextAttributes = [.foregroundColor: UIColor.white]
            navigationController.navigationBar.barStyle = .black
            navigationController.navigationBar.tintColor = .white
            
            
            let appStartPoint = UIStoryboard.auth.instantiateViewController(withIdentifier: "SplashViewController") as! SplashViewController
            
            navigationController.setViewControllers([appStartPoint], animated: true)
            return navigationController
        } else {
            return Tabbar.createTabBarWithNavigationBar(owner: owner)
        }
    }
    
}
