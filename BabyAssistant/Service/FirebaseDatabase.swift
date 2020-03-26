//
//  FirebaseDatabase.swift
//  BabyAssistant
//
//  Created by Ferhan Akkan on 24.03.2020.
//  Copyright © 2020 Ferhan Akkan. All rights reserved.
//

import Firebase


final class FirebaseDatabase {
    
    lazy var topicsArray: [TopicsModel] = []
    lazy var messageArray: [MessageModel] = []
    
    internal func getTopics(completion: @escaping([TopicsModel]) -> Void) {
        let fireStoreDatabase = Firestore.firestore()
        fireStoreDatabase.collection("Topics").addSnapshotListener { (snapshot, error) in
            if error != nil {
                print(error!)
            } else {
                if snapshot?.isEmpty != true && snapshot != nil {
                    self.topicsArray.removeAll()
                    for document in snapshot!.documents {
                        if let title = document.get("Title") as? String, let subTitle = document.get("Subtitle") as? String{
                            let data = TopicsModel(title: title, subTitle: subTitle)
                            self.topicsArray.append(data)
                        }
                    }
                    DispatchQueue.main.async {
                        completion(self.topicsArray)
                    }
                }
            }
        }
    }
    
    internal func getSelectedTopicMessage(owner: MessageViewController ,completion: @escaping([MessageModel]) -> Void) {
        let fireStoreDatabase = Firestore.firestore()
        fireStoreDatabase.collection("TopicDatas").document(AppManager.shared.selectedForumTopic!).collection("Message").order(by: "Time").addSnapshotListener { (snapshot, error) in
            if error != nil {
                print(error!)
            } else {
                if snapshot?.isEmpty != true && snapshot != nil {
                    self.messageArray.removeAll()
                    for document in snapshot!.documents {
                        if let title = document.get("Title") as? String, let username = document.get("Username") as? String, let subtitle = document.get("Subtitle") as? String{
                            let data = MessageModel(title: title,subtitle: subtitle, username: username)
                            self.messageArray.append(data)
                        }
                    }
                    DispatchQueue.main.async {
                        completion(self.messageArray)
                        owner.tableView?.reloadData()
                        if !self.messageArray.isEmpty {
                            owner.tableView?.scrollToRow(at: IndexPath(row: 0, section: self.messageArray.count-1), at: .bottom, animated: true)
                        }
                    }
                }
            }
        }
    }
    
    internal func sendMessageToTopic(message: String) {
        let fireStoreDatabase = Firestore.firestore()
        let docData: [String: Any] = [
            "Username": Auth.auth().currentUser?.displayName,
            "Title": message,
            "Subtitle": "",
            "Time": Date().timeIntervalSince1970
        ]
        fireStoreDatabase.collection("TopicDatas").document(AppManager.shared.selectedForumTopic!).collection("Message").addDocument(data: docData) { err in
            if let err = err {
                AppManager.shared.messagePresent(title: "OOPS", message: err as! String , type: .error)
            } else {
                print("Document successfully written!")
            }
        }
    }
    
    internal func setTopicTitle(title: String, subtitle: String, usernameController:Bool, completion: @escaping(Bool) -> Void) {
        let fireStoreDatabase = Firestore.firestore()
        var username = ""
        if usernameController {
            username = (Auth.auth().currentUser?.displayName)!
        } else {
            username = "Anonymous"
        }
         let docData: [String: Any] = [
             "Username": username,
             "Title": title,
             "Subtitle": subtitle,
             "Time": Date().timeIntervalSince1970
         ]
         fireStoreDatabase.collection("TopicDatas").document(title).collection("Message").addDocument(data: docData) { err in
             if let err = err {
                 AppManager.shared.messagePresent(title: "OOPS", message: err as! String , type: .error)
             } else {
                 print("Document successfully written!")
             }
         }
        fireStoreDatabase.collection("Topics").document(title).setData(docData) { err in
            if let err = err {
                AppManager.shared.messagePresent(title: "OOPS", message: err as! String , type: .error)
            } else {
                print("Document successfully written!")
                DispatchQueue.main.async {
                    completion(true)
                }
            }
        }

    }
    
}
