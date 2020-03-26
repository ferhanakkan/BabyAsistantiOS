//
//  UIButton.swift
//  BabyAssistant
//
//  Created by Ferhan Akkan on 26.03.2020.
//  Copyright © 2020 Ferhan Akkan. All rights reserved.
//

import UIKit

extension UIButton {
    func setMyButton(title: String) {
        setTitle(title, for: .normal)
        setTitleColor(.red, for: .normal)
        cornerRadius = 15
        backgroundColor = .backgroundGreen
        layer.borderWidth = 3
        layer.borderColor = UIColor.gray.cgColor
    }
}

