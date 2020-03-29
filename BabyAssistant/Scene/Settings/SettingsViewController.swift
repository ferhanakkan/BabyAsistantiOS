//
//  SettingsViewController.swift
//  BabyAssistant
//
//  Created by Ferhan Akkan on 27.03.2020.
//  Copyright © 2020 Ferhan Akkan. All rights reserved.
//

import UIKit
import Firebase

final class SettingViewController: UIViewController {
 
    private let settingsViewModel = SettingsViewModel()
    
    lazy var tableView: UITableView? = nil
    lazy var imageView: UIImageView? = nil
    lazy var imagePicker: UIImagePickerController? = UIImagePickerController()
    var firebase = FirebaseUser()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        settingsViewModel.setUI(self)
        imageView!.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(imageTapped)))
        imageView!.isUserInteractionEnabled = true
    }
    
}

//MARK: - TableView Delegate & DataSource
extension SettingViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 3
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
        switch indexPath.row {
        case 0:
            cell.textLabel?.text = "Change password"
            cell.accessoryType = .detailButton
        case 1:
            cell.textLabel?.text = "Delete User"
            cell.accessoryType = .detailButton
        case 2:
            cell.textLabel?.text = "Edit Language"
            cell.accessoryType = .disclosureIndicator
        default:
            break
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        switch indexPath.row {
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
            self.present(alert, animated: true)
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
            self.present(alert, animated: true)
        default:
            break
        }
    }
}

//MARK: - Image Picker

extension SettingViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    @objc func imageTapped() {
        settingsViewModel.openAlert(owner: self)
    }
    
    internal func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        picker.dismiss(animated: true, completion: nil)
        let image = info[UIImagePickerController.InfoKey.originalImage] as? UIImage
        imageView?.image = image
        settingsViewModel.sendSelectedImage(image: image!)
    }
}

