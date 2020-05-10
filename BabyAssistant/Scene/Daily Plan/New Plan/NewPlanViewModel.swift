//
//  NewPlanViewModel.swift
//  BabyAssistant
//
//  Created by Ferhan Akkan on 5.05.2020.
//  Copyright © 2020 Ferhan Akkan. All rights reserved.
//

import UIKit
import BEMCheckBox
import RealmSwift

struct NewPlanViewModel {
    
    let realm = try! Realm()
    
    //MARK: - Setup UI
    internal func setView(owner: NewPlanViewController) {
        setMain(owner: owner)
        setTextfield(owner: owner)
        setButtons(owner: owner)
        setImageButton(owner: owner)
    }
    
    internal func setMain(owner: NewPlanViewController) {
        owner.view.backgroundColor = UIColor.black.withAlphaComponent(0.80)
        owner.view.isOpaque = false
        
        owner.mainSubView = UIView()
        owner.mainSubView?.cornerRadius = 15
        owner.mainSubView?.backgroundColor = .white
        
        owner.view.addSubview(owner.mainSubView!)
        
        owner.mainSubView?.snp.makeConstraints({ (make) in
            make.height.equalTo(owner.view.frame.height*0.6)
            make.width.equalTo(owner.view.frame.width*0.8)
            make.center.equalToSuperview()
        })
    }
    
    internal func setTextfield(owner: NewPlanViewController) {
        owner.titleTextfield = UITextField()
        
        owner.titleTextfield?.borderStyle = .roundedRect
        owner.titleTextfield?.placeholder = "Plan Title"
        
        owner.mainSubView!.addSubview(owner.titleTextfield!)
        owner.titleTextfield?.snp.makeConstraints({ (make) in
            make.leading.top.equalToSuperview().offset(20)
            make.trailing.equalToSuperview().offset(-20)
            make.height.equalTo(50)
        })
        
        owner.subTitleTextfield = UITextField()
        
        owner.subTitleTextfield?.borderStyle = .roundedRect
        owner.subTitleTextfield?.placeholder = "Plan Description"
        
        owner.mainSubView!.addSubview(owner.subTitleTextfield!)
        owner.subTitleTextfield?.snp.makeConstraints({ (make) in
            make.leading.equalToSuperview().offset(20)
            make.trailing.equalToSuperview().offset(-20)
            make.height.equalTo(50)
            make.top.equalTo((owner.titleTextfield?.snp.bottom)!).offset(20)
        })
    }
    
    internal func setButtons(owner: NewPlanViewController) {
        owner.cancelButton = UIButton()
        owner.cancelButton?.setMyButton(title: "Cancel")
        owner.mainSubView?.addSubview(owner.cancelButton!)
        
        owner.cancelButton?.snp.makeConstraints({ (make) in
            make.bottom.trailing.equalToSuperview().offset(-20)
            make.leading.equalToSuperview().offset(20)
            make.height.equalTo(35)
        })
        
        owner.createButton = UIButton()
        owner.createButton?.setMyButton(title: "Create")
        owner.mainSubView?.addSubview(owner.createButton!)
        
        owner.createButton?.snp.makeConstraints({ (make) in
            make.trailing.equalToSuperview().offset(-20)
            make.leading.equalToSuperview().offset(20)
            make.height.equalTo(35)
            make.bottom.equalTo((owner.cancelButton?.snp.top)!).offset(-20)
        })
    }
    
}

//MARK: - ChechBox Setup

extension NewPlanViewModel {
    func setImageButton(owner: NewPlanViewController) {
        
        let title = UILabel()
        title.numberOfLines = 0
        title.text = "Select plan image (Optional)"
        owner.mainSubView?.addSubview(title)
        title.snp.makeConstraints { (make) in
            make.top.equalTo((owner.subTitleTextfield?.snp.bottom)!).offset(20)
            make.leading.equalToSuperview().offset(20)
        }
        
        owner.imageButton = UIButton()
        owner.imageButton!.cornerRadius = 15
        owner.imageButton!.layer.borderWidth = 2
        owner.imageButton!.layer.masksToBounds = false
        owner.imageButton!.layer.borderColor = UIColor.gray.cgColor
        owner.imageButton!.clipsToBounds = true
        owner.imageButton!.translatesAutoresizingMaskIntoConstraints = false
        owner.imageButton?.setImage(UIImage(named: "gray"), for: .normal)
        owner.mainSubView?.addSubview(owner.imageButton!)
        owner.imageButton?.snp.makeConstraints({ (make) in
            make.height.width.equalTo(30)
            make.centerY.equalTo(title)
            make.leading.equalTo(title.snp.trailing).offset(20)
            make.trailing.equalToSuperview().offset(-20)
        })
    }

}

//MARK: - Button Actions

extension NewPlanViewModel {
    
    func createTopic(owner: NewPlanViewController, _ object: DailyPlanRealmModel) {
        do {
            try realm.write {
                realm.add(object)
            }
        } catch {
            AppManager.shared.messagePresent(title: "OPPS", message: "Plan didn't saved", type: .error)
        }
        owner.dismiss(animated: true, completion: nil)
    }
    
    func cancelTopic(owner: NewPlanViewController) {
        owner.dismiss(animated: true, completion: nil)
    }
}

//MARK: - Set Gesture && Profile Image Actions

extension NewPlanViewModel {
    internal func openAlert(owner: NewPlanViewController) {
        
        let alert: UIAlertController = UIAlertController(title: "Chose which way do you prefer", message: nil, preferredStyle: UIAlertController.Style.actionSheet)
        
        let cameraAction = UIAlertAction(title: "Camera".localized, style: UIAlertAction.Style.default) {
            UIAlertAction in
            self.openCamera(owner: owner)
        }
        
        let galleryAction = UIAlertAction(title: "Galery", style: UIAlertAction.Style.default) {
            UIAlertAction in
            self.openGallery(owner: owner)
        }
        
        let cancelAction = UIAlertAction(title: "Cancel", style: UIAlertAction.Style.default) {
            UIAlertAction in
        }
        
        owner.imagePicker?.delegate = owner
        
        alert.addAction(cameraAction)
        alert.addAction(galleryAction)
        alert.addAction(cancelAction)
        
        let device = UIDevice.current
        
        if device.userInterfaceIdiom == .phone {
            
            owner.present(alert, animated: true, completion: nil)
        }
        
    }
    
    private func openCamera(owner: NewPlanViewController) {
        if(UIImagePickerController .isSourceTypeAvailable(UIImagePickerController.SourceType.camera)) {
            owner.imagePicker!.sourceType = UIImagePickerController.SourceType.camera
            owner.imagePicker!.allowsEditing = false
            owner.present(owner.imagePicker!, animated: true, completion: nil)
        }
        else {
            let alert  = UIAlertController(title: "OOPS", message: "Unknow Error", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "Cancel", style: .default, handler: nil))
            owner.present(alert, animated: true, completion: nil)
        }
    }
    
    private func openGallery(owner: NewPlanViewController) {
        owner.imagePicker!.sourceType = UIImagePickerController.SourceType.photoLibrary
        owner.imagePicker!.allowsEditing = true
        owner.present(owner.imagePicker!, animated: true, completion: nil)
    }
    
    private func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        picker.dismiss(animated: true, completion: nil)
    }
        
}


