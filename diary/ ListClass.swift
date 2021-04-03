//
//   ListClass.swift
//  diary
//
//  Created by Oleg on 3/30/21.
//

import UIKit
import RealmSwift
import SwiftyJSON



class List: Object {
    
    @objc dynamic var id : String?
    @objc dynamic var dateStart: Date?
    @objc dynamic var dateStartDay: String?
    @objc dynamic var dateFinish: Date?
    @objc dynamic var dateFinishDay: String?
    @objc dynamic var name: String = ""
    @objc dynamic var descriptionlist: String?
    
    convenience init(id: String, name: String, descriptionlist: String, dateStart: Date, dateFinish: Date) {
        self.init()
        
        self.id = id
        self.name = name
        self.descriptionlist = descriptionlist
        self.dateStart = dateStart
        self.dateFinish = dateFinish
        self.dateStartDay = dateFormatterOffTime.string(from: dateStart)
        self.dateFinishDay = dateFormatterOffTime.string(from: dateFinish)
        
    }
    override static func primaryKey() -> String? { //you need this in case you will want to update this object in Realm
       return "id"
    }

//    convenience init(courseJson: JSON) {
//
//       self.id = courseJson["id"].stringValue
//       self.name = courseJson["book"].stringValue
//       self.descriptionlist = courseJson["lesson"].stringValue
//        self.dateStart = courseJson["dateStart"].date
//        self.dateFinish = courseJson["dateFinish"].date
//        self.dateStartDay = dateFormatterOffTime.string(from: dateStart).stringValue
//        self.dateFinishDay = dateFormatterOffTime.string(from: dateFinish).stringValue
//    }
}
