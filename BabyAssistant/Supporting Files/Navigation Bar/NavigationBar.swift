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
            return NavigationBar.navigationBarSplash()
    }

    class func navigationBarSplash() -> UINavigationController {
        let navigationController = UINavigationController()
        navigationController.navigationBar.isTranslucent = false
        navigationController.navigationBar.barTintColor = UIColor.backgroundGreen
        navigationController.navigationBar.titleTextAttributes = [.foregroundColor: UIColor.white]
        navigationController.navigationBar.tintColor = .white
        navigationController.navigationBar.barStyle = .black
        
        
        let appStartPoint = SplashViewController()
        
        navigationController.setViewControllers([appStartPoint], animated: true)
        return navigationController
    }
    
}
