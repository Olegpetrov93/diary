//
//  StorigeManager.swift
//  diary
//
//  Created by Oleg on 4/1/21.
//

import RealmSwift

let realm = try! Realm()

final class StorageManager {
    
    static func saveObject(_ list: List) {
        
        try! realm.write {
            realm.add(list)
        }
    }
    static func deleteObject(_ list: List) {
        
        try! realm.write {
            
            realm.delete(list)
        }
    }
}
