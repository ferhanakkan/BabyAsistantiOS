//
//  SettingsViewModel.swift
//  BabyAssistant
//
//  Created by Ferhan Akkan on 27.03.2020.
//  Copyright © 2020 Ferhan Akkan. All rights reserved.
//

import UIKit
import Firebase

struct SettingsViewModel {
    
    //MARK: - Setup UI
    internal func setUI(_ owner: SettingViewController) {
        owner.view.backgroundColor = .white
        setImageView(owner)
        setTableView(owner)
    }
    
    internal func setImageView(_ owner: SettingViewController) {
        let myImageView:UIImageView = UIImageView()
        owner.imageView = myImageView
        owner.imageView!.contentMode = .scaleAspectFit
        owner.imageView!.makeRounded()
        
        if let imageUrl = Auth.auth().currentUser?.photoURL {
            owner.imageView!.kf.setImage(with: imageUrl )
        } else {
            owner.imageView!.image = UIImage(named: "avatar")
        }
        
        owner.view.addSubview(owner.imageView!)
        
        owner.imageView!.snp.makeConstraints { (make) in
            make.width.equalTo(100)
            make.height.equalTo(100)
            make.centerX.equalToSuperview()
            make.top.equalToSuperview().offset(AppManager.shared.safeAreaTopInset+70)
        }
    }
    
    internal func setTableView(_ owner: SettingViewController) {
        owner.tableView = UITableView()
        owner.view.addSubview(owner.tableView!)
        owner.tableView!.snp.makeConstraints { (make) in
            make.leading.equalToSuperview().offset(5)
            make.trailing.equalToSuperview().offset(-5)
            make.top.equalTo((owner.imageView?.snp.bottom)!).offset(30)
            make.bottom.equalToSuperview()
        }
        
        owner.tableView!.dataSource = owner
        owner.tableView!.delegate = owner
        
        owner.tableView!.backgroundColor = .white
        owner.tableView!.separatorColor = .clear
        
//        owner.tableView!.register(UINib(nibName: "TitleTopiceTableViewCell", bundle: nil), forCellReuseIdentifier: "TitleTopiceTableViewCell")
//        owner.tableView!.register(UINib(nibName: "MessageTableViewCell", bundle: nil), forCellReuseIdentifier: "MessageTableViewCell")


    }
    
    
    
    //MARK: - Set Gesture && Profile Image Actions
    
    internal func openAlert(owner: SettingViewController) {
         
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
     
    private func openCamera(owner: SettingViewController) {
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
     
    private func openGallery(owner: SettingViewController) {
        owner.imagePicker!.sourceType = UIImagePickerController.SourceType.photoLibrary
        owner.imagePicker!.allowsEditing = true
        owner.present(owner.imagePicker!, animated: true, completion: nil)
     }
     
    private func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
         picker.dismiss(animated: true, completion: nil)
     }
    
    internal func sendSelectedImage(image: UIImage) {
        let storage = Storage.storage().reference(withPath: "profileImage")
        if let name = Auth.auth().currentUser?.displayName {
            
            let riversRef = storage.child("\(name).jpg")
            
            _ = riversRef.putData((image.jpegData(compressionQuality: 0.5))!, metadata: nil) { (metadata, error) in
                guard let metadata = metadata else {
                    return
                }
                _ = metadata.size
                // You can also access to download URL after upload.
                riversRef.downloadURL { (url, error) in
                    guard let downloadURL = url else {return}
                    let changeRequest = Auth.auth().currentUser?.createProfileChangeRequest()
                    changeRequest?.photoURL = downloadURL
                    changeRequest?.commitChanges { (_) in
                    }
                }
            }
        }

    }
    
}
