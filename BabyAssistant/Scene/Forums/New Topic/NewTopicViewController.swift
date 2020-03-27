//
//  NewTopic.swift
//  BabyAssistant
//
//  Created by Ferhan Akkan on 26.03.2020.
//  Copyright © 2020 Ferhan Akkan. All rights reserved.
//

import UIKit
import SnapKit
import BEMCheckBox

final class NewTopicViewController: BaseViewController {
    
    internal lazy var mainSubView:UIView? = nil
    internal lazy var titleTextfield:UITextField? = nil
    internal lazy var subTitleTextfield: UITextField? = nil
    internal lazy var createButton: UIButton? = nil
    internal lazy var cancelButton: UIButton? = nil
    internal lazy var chechBox : BEMCheckBox? = nil
    
    private lazy var newTopicViewModel = NewTopicViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        newTopicViewModel.setView(owner: self)
        createButton?.addTarget(self, action: #selector(createTopic), for: .touchUpInside)
        cancelButton?.addTarget(self, action: #selector(cancelTopic), for: .touchUpInside)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
    
    @objc func createTopic() {
        newTopicViewModel.createTopic(owner: self)

    }
    
    @objc func cancelTopic() {
        newTopicViewModel.cancelTopic(owner: self)
    }
}
