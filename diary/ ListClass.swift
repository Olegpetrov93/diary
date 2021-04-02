//
//   ListClass.swift
//  diary
//
//  Created by Oleg on 3/30/21.
//

import UIKit
import RealmSwift



class List: Object {
    
    @objc dynamic var id : String?
    @objc dynamic var dateStart: Date?
    @objc dynamic var dateStartDay: String {
        get {
            let dateStartDay = dateFormatterOffTime.string(from: dateStart!)
            return dateStartDay
        }
    }
    @objc dynamic var dateFinish: Date?
    @objc dynamic var dateFinishDay: String
    @objc dynamic var name: String = ""
    @objc dynamic var descriptionlist: String?
    
    convenience init(id: String, dateStart: Date, dateFinish: Date, name: String, descriptionlist: String) {
        self.init()
        self.name = name
        self.id = id
        self.dateStart = dateStart
        self.dateFinish = dateFinish
        self.descriptionlist = descriptionlist
    }
}
