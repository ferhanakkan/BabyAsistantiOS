//
//  ErrorSuccessViewController.swift
//  BabyAssistant
//
//  Created by Ferhan Akkan on 21.03.2020.
//  Copyright © 2020 Ferhan Akkan. All rights reserved.
//

import UIKit

class ErrorSuccessViewController: UIViewController {
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var messageLabel: UILabel!
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var mainView: UIView!
    
    lazy var imageTypeSelector: ImageType = .error
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
            switch imageTypeSelector {
            case .error:
                imageView.image = #imageLiteral(resourceName: "error")
            case .success:
                imageView.image = #imageLiteral(resourceName: "success")
            }
    }
    
    @IBAction func buttonPressed(_ sender: UIButton) {
        dismiss(animated: true, completion: nil)
    }
}

enum ImageType {
    case success
    case error
}
