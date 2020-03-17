//
//  Tabbar.swift
//  BabyAssistant
//
//  Created by Ferhan Akkan on 16.03.2020.
//  Copyright © 2020 Ferhan Akkan. All rights reserved.
//


import UIKit

class Tabbar {
    class func createTabBarWithNavigationBar(owner: Any) -> UINavigationController {
        var navigationController = UINavigationController()
        let tabController = UITabBarController()

        //Storyboard usage
        let homePage = UIStoryboard.trash.instantiateViewController(withIdentifier: "TrashDataViewController") as! TrashDataViewController
        
        let profilePage = UIStoryboard.trash.instantiateViewController(withIdentifier: "TrashDataViewController") as! TrashDataViewController
        
        homePage.title = "Home Page"
        profilePage.title = "Profile"

        tabController.viewControllers = [homePage,profilePage]
//        tabController.tabBar.backgroundColor = UIColor(red: 95/255, green: 108/255, blue: 175/255, alpha: 1)

        tabController.tabBar.items?[0].image = UIImage(named: "test")
        tabController.tabBar.items![0].selectedImage = UIImage(named: "test")
        tabController.tabBar.items?[1].image = UIImage(named: "test")
        tabController.tabBar.items![1].selectedImage = UIImage(named: "test")

        navigationController = UINavigationController(rootViewController: tabController)
        return navigationController
    }
}
