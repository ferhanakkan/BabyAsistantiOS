//
//  SettingsViewController.swift
//  BabyAssistant
//
//  Created by Ferhan Akkan on 27.03.2020.
//  Copyright © 2020 Ferhan Akkan. All rights reserved.
//

import UIKit

final class SettingViewController: UIViewController {
 
    private let settingsViewModel = SettingsViewModel()
    
    lazy var tableView: UITableView? = nil
    lazy var imageView: UIImageView? = nil
    lazy var imagePicker: UIImagePickerController? = UIImagePickerController()
    
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
        return settingsViewModel.setTableViewRows(indexpath: indexPath.row)
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        settingsViewModel.didSelectTableViewRow(indexpath: indexPath.row, owner: self)
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

