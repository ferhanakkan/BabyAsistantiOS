//
//  DailyPlanModel.swift
//  BabyAssistant
//
//  Created by Ferhan Akkan on 7.05.2020.
//  Copyright © 2020 Ferhan Akkan. All rights reserved.
//

import Foundation
import RealmSwift

class DailyPlanRealmModel: Object {
    @objc dynamic var title: String?
    @objc dynamic var descriptionsss: String?
    @objc dynamic var repeatStatusww = false
    @objc dynamic var pic: Data? = nil
    @objc dynamic var time: Date? = nil
//    let imageData: Data 
}
