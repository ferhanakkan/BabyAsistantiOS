//
//  DailyPlanDetailViewModel.swift
//  BabyAssistant
//
//  Created by Ferhan Akkan on 7.05.2020.
//  Copyright © 2020 Ferhan Akkan. All rights reserved.
//

import UIKit
import RealmSwift

struct DailyPlanDetailViewModel {
    
    var selectedIndex:Int? = nil
    var delegate:DidPlanDelete?
    
    func deleteSelectedPlanFromDatabase() {
        
        let realm = try! Realm()
         let res = realm.objects(DailyPlanRealmModel.self)[selectedIndex!]
            do {
                try realm.write{
                    realm.delete(res)
                    self.delegate?.planDelete()
                }
            } catch {
                print("Error saving done status, \(error)")
            }
    }
}

protocol DidPlanDelete {
    func planDelete()
}
