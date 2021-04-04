//
//   ListClass.swift
//  diary
//
//  Created by Oleg on 3/30/21.
//

import UIKit
import RealmSwift
import SwiftyJSON

final class List: Object {
    
    @objc dynamic var id : String?
    @objc dynamic var dateStart: Date?
    @objc dynamic var dateStartDay: String?
    @objc dynamic var dateFinish: Date?
    @objc dynamic var dateFinishDay: String?
    @objc dynamic var name: String = ""
    @objc dynamic var descriptionlist: String?
    
    var workItem: CodableWorkItem {
        return CodableWorkItem(id: id ?? "",
                               date_start: dateStart?.timeIntervalSince1970 ?? 0,
                               date_finish: dateFinish?.timeIntervalSince1970 ?? 0,
                               name: name,
                               description: descriptionlist ?? "")
    }
    
    override static func primaryKey() -> String? { //you need this in case you will want to update this object in Realm
        return "id"
    }
    
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
    
    convenience init(from item: CodableWorkItem) {
        self.init(id: item.id,
                  name: item.name,
                  descriptionlist: item.description,
                  dateStart: Date(timeIntervalSince1970: item.date_start),
                  dateFinish: Date(timeIntervalSince1970: item.date_finish))
    }

    
    convenience init(courseJson: JSON) {
        self.init()
        
        self.id = courseJson["id"].stringValue
        self.name = courseJson["book"].stringValue
        self.descriptionlist = courseJson["lesson"].stringValue
        self.dateStart = Date(courseJson["dateStart"].stringValue)
        self.dateFinish = Date(courseJson["dateFinish"].stringValue)
        self.dateStartDay = courseJson["dateStartDay"].stringValue
        self.dateFinishDay = courseJson["dateFinishDay"].stringValue
    }
    
    func createhourFinish(toDay: Date) -> Float {
        if Calendar.current.component(.day, from: (toDay)) < Calendar.current.component(.day, from: (self.dateFinish!)) {
            return Float(24)
        } else {
        return Float(Calendar.current.component(.hour, from: (self.dateFinish!)))
        }
    }
    
    func createhourStart(toDay: Date) -> Float {
        if Calendar.current.component(.day, from: (toDay)) > Calendar.current.component(.day, from: (self.dateStart!)) {
            return Float(0)
        } else {
            return Float(Calendar.current.component(.hour, from: (self.dateStart!)))
        }
    }
}

