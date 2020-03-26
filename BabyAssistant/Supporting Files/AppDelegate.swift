//
//  AppDelegate.swift
//  BabyAssistant
//
//  Created by Ferhan Akkan on 16.03.2020.
//  Copyright © 2020 Ferhan Akkan. All rights reserved.
//

import UIKit
import Localize
import IQKeyboardManagerSwift
import Firebase

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    var window: UIWindow?
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.

        AppManager.shared.setReachability()
        setLanguage()
        setKeyboard()
        FirebaseApp.configure()

        window = UIWindow(frame: UIScreen.main.bounds)
        selectRoot()
        window?.makeKeyAndVisible()
        
        return true
    }
    
    // MARK: UISceneSession Lifecycle
    @available(iOS 13.0, *)
    func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
        // Called when a new scene session is being created.
        // Use this method to select a configuration to create the new scene with.
        return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
    }
    @available(iOS 13.0, *)
    func application(_ application: UIApplication, didDiscardSceneSessions sceneSessions: Set<UISceneSession>) {
        // Called when the user discards a scene session.
        // If any sessions were discarded while the application was not running, this will be called shortly after application:didFinishLaunchingWithOptions.
        // Use this method to release any resources that were specific to the discarded scenes, as they will not return.
    }
    
}

//MARK: Set Language

extension AppDelegate {
    
    func setLanguage() {
        //Localize
        Localize.shared.update(provider: .json)
        Localize.shared.update(fileName: "lang")
        Localize.shared.update(defaultLanguage: "en")
        
        let userDefaults = UserDefaults.standard
        let lang = Locale.preferredLanguages[0]
        if userDefaults.value(forKey: "lang") == nil {
            switch lang{
            case "en-US":
                Localize.update(language: "en")
                userDefaults.set("en", forKey: "lang")
            case "tr-TR":
                Localize.update(language: "tr")
                userDefaults.set("tr", forKey: "lang")
            default:
                Localize.update(language: "en")
                userDefaults.set("en", forKey: "lang")
            }
            userDefaults.synchronize()
        }
        
    }
    
    //MARK: Set Keyboard
    
    func setKeyboard() {
        IQKeyboardManager.shared.enable = true
        IQKeyboardManager.shared.shouldResignOnTouchOutside = true
    }
    
    //MARK: - Select Root
    private func selectRoot() {
        let currentUser = Auth.auth().currentUser
        if let rememberMe = UserDefaults.standard.value(forKey: "rememberMe") as? Bool {
            if currentUser != nil && rememberMe {
                window?.rootViewController = Tabbar.createTabBarWithNavigationBar(owner: self)
            } else {
                window?.rootViewController = NavigationBar.createNavigatonController(owner: self)
            }
            
        } else {
            window?.rootViewController = NavigationBar.createNavigatonController(owner: self)
        }
    }
}

