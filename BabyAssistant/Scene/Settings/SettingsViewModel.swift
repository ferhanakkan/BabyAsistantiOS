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
    
    var firebase = FirebaseUser()
    
    //MARK: - Setup UI
    internal func setUI(_ owner: SettingViewController) {
        owner.view.backgroundColor = .white
        setImageView(owner)
        setTableView(owner)
    }
    
    internal func setImageView(_ owner: SettingViewController) {
        let myImageView:UIImageView = UIImageView()
        owner.imageView = myImageView
        owner.imageView!.contentMode = .scaleAspectFill
        owner.imageView!.layer.cornerRadius = 50
        owner.imageView!.layer.borderWidth = 2
        owner.imageView!.layer.masksToBounds = false
        owner.imageView!.layer.borderColor = UIColor.gray.cgColor
        owner.imageView!.clipsToBounds = true

        
        DispatchQueue.main.async {
            if let data = UserDefaults.standard.value(forKey: "profileImage") as? Data{
                owner.imageView?.image = UIImage(data: data)
            } else {
                owner.imageView!.image = UIImage(named: "avatar")
            }
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
        owner.tableView?.isScrollEnabled = false
        owner.tableView!.tableFooterView = UIView(frame: .zero)
        owner.tableView!.backgroundColor = .white
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
            
            let store = storage.child("\(name).jpg")
            
            store.putData((image.jpegData(compressionQuality: 0.1))!, metadata: nil) { (metadata, error) in
                store.downloadURL { (url, error) in
                    guard let downloadURL = url else {return}
                    let changeRequest = Auth.auth().currentUser?.createProfileChangeRequest()
                    changeRequest?.photoURL = downloadURL
                    changeRequest?.commitChanges { (_) in
                    }
                }
            }
        }

    }
    
    //MARK: - TableView
    
    internal func setTableViewRows(indexpath: Int) -> UITableViewCell{
        let cell = UITableViewCell()
        switch indexpath {
        case 0:
            cell.textLabel?.text = "Change password"
            cell.accessoryType = .detailButton
        case 1:
            cell.textLabel?.text = "Delete User"
            cell.accessoryType = .detailButton
//        case 2:
//            cell.textLabel?.text = "Edit Language"
//            cell.accessoryType = .disclosureIndicator
        default:
            break
        }
        return cell
    }
    
    internal func didSelectTableViewRow(indexpath: Int,owner: SettingViewController) {
        switch indexpath {
        case 0:
            let alert = UIAlertController(title: "Do you want to Change Password?", message: "If yes we will send you a mail to change your password.", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "Yes", style: .default, handler: { action in
                if let email = Auth.auth().currentUser?.email {
                    Auth.auth().sendPasswordReset(withEmail: email) { error in
                        AppManager.shared.messagePresent(title: "Success", message: "We send you a mail chech you mail box", type: .success)
                        self.firebase.signOut()
                    }
                }
            }))
            alert.addAction(UIAlertAction(title: "No", style: .default, handler: { action in
            }))
            owner.present(alert, animated: true)
        case 1:
            let alert = UIAlertController(title: "Do you want to Delete your account?", message: "if you delete your account you can register with same mail again.", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "Yes", style: .default, handler: { action in
                let user = Auth.auth().currentUser
                user?.delete { error in
                  if let error = error {
                    AppManager.shared.messagePresent(title: "Error", message: error.localizedDescription, type: .error)
                  } else {
                    AppManager.shared.messagePresent(title: "Success", message: "Your account has been deleted", type: .success)
                    self.firebase.signOut()
                  }
                }
            }))
            alert.addAction(UIAlertAction(title: "No", style: .default, handler: { action in
            }))
            owner.present(alert, animated: true)
//        case 2:
//            let vc = LanguageViewController()
//            owner.navigationController?.show(vc, sender: nil)
        default:
            break
        }
    }
    
}
