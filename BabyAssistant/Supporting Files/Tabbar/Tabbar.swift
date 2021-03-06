//
//  Tabbar.swift
//  BabyAssistant
//
//  Created by Ferhan Akkan on 16.03.2020.
//  Copyright © 2020 Ferhan Akkan. All rights reserved.
//


import UIKit
import Firebase

class Tabbar {
    class func createTabBarWithNavigationBar(owner: Any) -> UITabBarController {
        
        let tabController = UITabBarController()

        let explore = ExploreViewController()
        let profilePage = DailyPlanViewController()
        
        if let imageUrl = Auth.auth().currentUser?.photoURL {
            let data = try? Data(contentsOf: imageUrl)
            UserDefaults.standard.setValue(data, forKey: "profileImage")
        }
        
        
        if Auth.auth().currentUser != nil {
            let forum = ForumTopicViewController()
            
            explore.title = "Explore"
            profilePage.title = "Daily Plan"
            forum.title = "Forum"

            tabController.viewControllers = [UINavigationController(rootViewController: explore),UINavigationController(rootViewController: profilePage),UINavigationController(rootViewController: forum)]
            
            tabController.tabBar.backgroundColor = .backgroundGreen
            tabController.tabBar.barTintColor = .backgroundGreen
            tabController.tabBar.tintColor = .darkGray

            tabController.tabBar.items?[0].image = UIImage(named: "explore")
            tabController.tabBar.items![0].selectedImage = UIImage(named: "explore")
            tabController.tabBar.items?[1].image = UIImage(named: "dailyplan")
            tabController.tabBar.items![1].selectedImage = UIImage(named: "dailyplan")
            tabController.tabBar.items?[2].image = UIImage(named: "forum")
            tabController.tabBar.items![2].selectedImage = UIImage(named: "forum")

            return tabController
        } else {
            let forum = SplashViewController()
            
            explore.title = "Explore"
            profilePage.title = "Daily Plan"
            forum.title = "Forum"

            tabController.viewControllers = [UINavigationController(rootViewController: explore),UINavigationController(rootViewController: profilePage),forum]
            
            tabController.tabBar.backgroundColor = .backgroundGreen
            tabController.tabBar.barTintColor = .backgroundGreen
            tabController.tabBar.tintColor = .darkGray

            tabController.tabBar.items?[0].image = UIImage(named: "explore")
            tabController.tabBar.items![0].selectedImage = UIImage(named: "explore")
            tabController.tabBar.items?[1].image = UIImage(named: "dailyplan")
            tabController.tabBar.items![1].selectedImage = UIImage(named: "dailyplan")
            tabController.tabBar.items?[2].image = UIImage(named: "forum")
            tabController.tabBar.items![2].selectedImage = UIImage(named: "forum")

            return tabController
        }
    }
}
