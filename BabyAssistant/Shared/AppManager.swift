//
//  AppManager.swift
//  BabyAssistant
//
//  Created by Ferhan Akkan on 16.03.2020.
//  Copyright © 2020 Ferhan Akkan. All rights reserved.
//
import UIKit

struct AppManager {
    
    static var shared = AppManager()
    
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

}
