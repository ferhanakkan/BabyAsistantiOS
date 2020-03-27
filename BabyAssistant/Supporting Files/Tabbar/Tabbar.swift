//
//  Tabbar.swift
//  BabyAssistant
//
//  Created by Ferhan Akkan on 16.03.2020.
//  Copyright © 2020 Ferhan Akkan. All rights reserved.
//


import UIKit

class Tabbar {
    class func createTabBarWithNavigationBar(owner: Any) -> UITabBarController {
        let tabController = UITabBarController()
        tabController.hidesBottomBarWhenPushed = true

        //Storyboard usage
        let explore = ExploreViewController()
        
        let profilePage = UIStoryboard.forum.instantiateViewController(withIdentifier: "ForumTopic") as! ForumTopicViewController
        
        let forum = UIStoryboard.forum.instantiateViewController(withIdentifier: "ForumTopic") as! ForumTopicViewController
        
        
        explore.title = "Explore"
        profilePage.title = "Profile"
        forum.title = "Forum"

        tabController.viewControllers = [UINavigationController(rootViewController: explore),UINavigationController(rootViewController: profilePage),UINavigationController(rootViewController: forum)]
        
        tabController.tabBar.backgroundColor = .backgroundGreen
        tabController.tabBar.barTintColor = .backgroundGreen
        tabController.tabBar.tintColor = .red

        tabController.tabBar.items?[0].image = UIImage(named: "test")
        tabController.tabBar.items![0].selectedImage = UIImage(named: "test")
        tabController.tabBar.items?[1].image = UIImage(named: "test")
        tabController.tabBar.items![1].selectedImage = UIImage(named: "test")
        tabController.tabBar.items?[2].image = UIImage(named: "test")
        tabController.tabBar.items![2].selectedImage = UIImage(named: "test")

        return tabController
    }
}
