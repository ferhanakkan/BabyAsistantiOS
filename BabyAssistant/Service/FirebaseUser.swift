//
//  FirebaseService.swift
//  BabyAssistant
//
//  Created by Ferhan Akkan on 22.03.2020.
//  Copyright © 2020 Ferhan Akkan. All rights reserved.
//

import Foundation
import Firebase

struct FirebaseUser {
 
    internal func resetPassword(email: String, completion: @escaping(Bool) -> Void) {
        Auth.auth().sendPasswordReset(withEmail: email) { error in
            if let error = error {
                AppManager.shared.messagePresent(title: "OOOPS", message: error.localizedDescription, type: .error)
            } else {
                AppManager.shared.messagePresent(title: "Success", message: "Reset Password Succesful, check your mailbox.", type: .success)
                completion(true)
            }
        }
    }
    
    internal func logIn(email: String , password: String, completion: @escaping(Bool) -> Void) {
        Auth.auth().signIn(withEmail: email, password: password) { authResult, error in
            if let error = error {
                AppManager.shared.messagePresent(title: "OOOOPS", message: error.localizedDescription, type: .error)
            } else {
                completion(false)
            }
        }
    }
    
    internal func createUser(email: String , password: String, username: String, completion: @escaping(Bool) -> Void) {
        Auth.auth().createUser(withEmail: email, password: password) { authResult, error in
            if let error = error {
                AppManager.shared.messagePresent(title: "OOOOPS", message: error.localizedDescription, type: .error)
            } else {
                self.setUsername(username: username) { (_) in
                    completion(true)
                }
            }
        }
    }
    
    internal func setUsername(username: String, completion: @escaping(Bool) -> Void) {
        let changeRequest = Auth.auth().currentUser?.createProfileChangeRequest()
        changeRequest?.displayName = username
        changeRequest?.commitChanges { (error) in
            completion(true)
        }
    }
    
    internal func signOut() {
        guard let delegate = UIApplication.shared.delegate else { return }
        guard let window = (delegate as! AppDelegate).window else { return }
        UserDefaults.standard.setValue(nil, forKey: "profileImage")
        let firebaseAuth = Auth.auth()
        do {
            try firebaseAuth.signOut()
            window.rootViewController = NavigationBar.createNavigatonController(owner: delegate)
        } catch let signOutError as NSError {
            print ("Error signing out: %@", signOutError)
        }
    }
    
}
