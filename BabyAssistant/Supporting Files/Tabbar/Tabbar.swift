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
        let homePage = NewTopicViewController()
        
        let profilePage = UIStoryboard.trash.instantiateViewController(withIdentifier: "TrashDataViewController") as! TrashDataViewController
        
        let forum = UIStoryboard.forum.instantiateViewController(withIdentifier: "ForumTopic") as! ForumTopicViewController
        
        
        homePage.title = "Home Page"
        profilePage.title = "Profile"
        forum.title = "Forum"

        tabController.viewControllers = [homePage,profilePage,forum]
        tabController.tabBar.backgroundColor = .backgroundGreen
        tabController.tabBar.barTintColor = .backgroundGreen
        tabController.tabBar.tintColor = .red

        tabController.tabBar.items?[0].image = UIImage(named: "test")
        tabController.tabBar.items![0].selectedImage = UIImage(named: "test")
        tabController.tabBar.items?[1].image = UIImage(named: "test")
        tabController.tabBar.items![1].selectedImage = UIImage(named: "test")
        tabController.tabBar.items?[2].image = UIImage(named: "test")
        tabController.tabBar.items![2].selectedImage = UIImage(named: "test")

        navigationController = UINavigationController(rootViewController: tabController)
        navigationController.navigationBar.barTintColor = .backgroundGreen
        
        navigationController.navigationBar.titleTextAttributes = [.foregroundColor: UIColor.gray]
        navigationController.navigationBar.tintColor = .gray
        navigationController.navigationBar.barStyle = .black
        return navigationController
    }
}
