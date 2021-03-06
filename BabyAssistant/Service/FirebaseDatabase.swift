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
    lazy var exploreArray: [ExploreModel] = []
    lazy var exploreDetailArray: [ExploreDetailModel] = []
    lazy var dailyPlanArray: [DailyPlanModel] = []
    
    internal func getOtherUsersImage(username: String, completion: @escaping(Data) -> Void) {
        let storage = Storage.storage().reference(withPath: "profileImage/\(username).jpg")

        storage.getData(maxSize: 1 * 1024 * 1024) { data, error in
          if let error = error {
            print(error.localizedDescription)
            print("error")
          } else {
            completion(data!)
          }
        }
    }
    
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
                DispatchQueue.main.async {
                    completion(true)
                }
            }
        }
        
    }
    
    internal func getExploreTopics(completion: @escaping([ExploreModel]) -> Void) {
        let fireStoreDatabase = Firestore.firestore()
        fireStoreDatabase.collection("ExploreTopics").order(by: "Time").addSnapshotListener { (snapshot, error) in
            if error != nil {
                print(error!)
            } else {
                if snapshot?.isEmpty != true && snapshot != nil {
                    self.exploreArray.removeAll()
                    var index = 0
                    for document in snapshot!.documents {
                        if let title = document.get("Title") as? String, let subTitle = document.get("Subtitle") as? String, let imageUrl = document.get("imageUrl") as? String, let time = document.get("Time") as? Int{
                            
                            let storage = Storage.storage()
                            let gsReference = storage.reference(forURL:imageUrl)
                            
                            
                            gsReference.downloadURL { url, error in
                                if let error = error {
                                    print(error)
                                } else {
                                    let data = ExploreModel(title: title, subtitle: subTitle, image: url!, time: time)
                                    self.exploreArray.append(data)
                                    if index == snapshot!.documents.count-1 {
                                        self.exploreArray =  self.exploreArray.sorted{ $0.time < $1.time }
                                        completion(self.exploreArray)
                                    }
                                    index += 1
                                }
                            }
                        }
                    }
                }
            }
        }
    }
    
    internal func getExploreDetails(title:String, completion: @escaping([ExploreDetailModel]) -> Void) {
        let fireStoreDatabase = Firestore.firestore()
        fireStoreDatabase.collection("ExploreTopics").document(title).collection("Detail").order(by: "Time", descending: true).addSnapshotListener { (snapshot, error) in
            if error != nil {
                print(error!)
            } else {
                if snapshot?.isEmpty != true && snapshot != nil {
                    self.exploreArray.removeAll()
                    var index = 0
                    for document in snapshot!.documents {
                        if let title = document.get("Title") as? String, let imageUrl = document.get("imageUrl") as? String, let time = document.get("Time") as? Int{
                            let storage = Storage.storage()
                            if title != "Video" {
                                let gsReference = storage.reference(forURL:imageUrl)
                                gsReference.downloadURL { url, error in
                                    if let error = error {
                                        print(error)
                                    } else {
                                        let data = ExploreDetailModel(title: title,imageUrl: url!, time: time)
                                        self.exploreDetailArray.append(data)
                                        if index == snapshot!.documents.count-1 {
                                            self.exploreDetailArray =  self.exploreDetailArray.sorted{ $0.time < $1.time }
                                            completion(self.exploreDetailArray)
                                        }
                                        index += 1
                                    }
                                }
                            }  else {
                                let data = ExploreDetailModel(title: title,imageUrl: URL(string: imageUrl)!, time: time)
                                self.exploreDetailArray.append(data)
                                if index == snapshot!.documents.count-1 {
                                    self.exploreDetailArray =  self.exploreDetailArray.sorted{ $0.time < $1.time }
                                    completion(self.exploreDetailArray)
                                }
                                index += 1
                            }
                        }
                    }
                }
            }
        }
    }
    
}
