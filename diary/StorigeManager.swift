//
//  StorigeManager.swift
//  diary
//
//  Created by Oleg on 4/1/21.
//

import RealmSwift

let realm = try! Realm()

class StorigeManadger {
    
    static func saveObject(_ list: List) {
        
        try! realm.write {
            realm.add(list)
        }
    }
    static func deliteObject(_ list: List) {
        
        try! realm.write {
            
            realm.delete(list)
        }
    }
}
