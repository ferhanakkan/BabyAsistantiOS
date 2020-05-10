//
//  NewPlanViewController.swift
//  BabyAssistant
//
//  Created by Ferhan Akkan on 5.05.2020.
//  Copyright © 2020 Ferhan Akkan. All rights reserved.
//

import UIKit
import SnapKit

final class NewPlanViewController: BaseViewController {
    
    internal lazy var mainSubView:UIView? = nil
    internal lazy var titleTextfield:UITextField? = nil
    internal lazy var subTitleTextfield: UITextField? = nil
    internal lazy var createButton: UIButton? = nil
    internal lazy var cancelButton: UIButton? = nil
    internal lazy var imageButton : UIButton? = nil
    
    lazy var newPlanViewModel = NewPlanViewModel()
    lazy var imagePicker: UIImagePickerController? = UIImagePickerController()

    var delegate:DidPlanAdded?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        newPlanViewModel.setView(owner: self)
        imageButton?.addTarget(self, action: #selector(imageButtonPressed), for: .touchUpInside)
        createButton?.addTarget(self, action: #selector(createTopic), for: .touchUpInside)
        cancelButton?.addTarget(self, action: #selector(cancelTopic), for: .touchUpInside)
    }
    
    @objc func imageButtonPressed() {
        newPlanViewModel.openAlert(owner: self)
    }

    @objc func createTopic() {
        if titleTextfield?.text != "" && subTitleTextfield?.text != "" {
            let planObject = DailyPlanRealmModel()
            planObject.title = titleTextfield?.text
            planObject.descriptionsss = subTitleTextfield?.text
            let pngData = imageButton!.imageView!.image!
            planObject.pic = pngData.jpegData(compressionQuality: 0.2)
            planObject.time = Date.from(year: 2020, month: 5, day: 31, hour: 24, min: 55)
            newPlanViewModel.createTopic(owner: self, planObject)
            delegate?.planAdded()
        } else {
            AppManager.shared.messagePresent(title: "OPSS", message: "Title or Description is empty", type: .error)
        }
    }
    
    @objc func cancelTopic() {
        newPlanViewModel.cancelTopic(owner: self)
    }
    
}

//MARK: - Image Picker

extension NewPlanViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    internal func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        picker.dismiss(animated: true, completion: nil)
        let image = info[UIImagePickerController.InfoKey.originalImage] as? UIImage
        imageButton?.setImage(image, for: .normal)
    }
}

protocol DidPlanAdded {
    func planAdded()
}
