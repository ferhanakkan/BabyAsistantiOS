//
//  UIStoryboard.swift
//  BabyAssistant
//
//  Created by Ferhan Akkan on 16.03.2020.
//  Copyright © 2020 Ferhan Akkan. All rights reserved.
//

import UIKit

public extension UIStoryboard {
    
    static var auth: UIStoryboard {
        return UIStoryboard(name: "Auth", bundle: .main)
    }
    
    static var trash: UIStoryboard {
        return UIStoryboard(name: "Trash", bundle: .main)
    }

    static var forum: UIStoryboard {
        return UIStoryboard(name: "Forum", bundle: .main)
    }
}

