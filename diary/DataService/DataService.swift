//
//  DataService.swift
//  diary
//
//  Created by Oleg on 4/4/21.
//

import Foundation
import RealmSwift

struct CodableWorkItem: Codable {
    let id: String
    let date_start: TimeInterval
    let date_finish: TimeInterval
    let name: String
    let description: String
}

final class DataService {
    
    static func importFrom(json: Data?) {
        guard let data = json, let arr = [CodableWorkItem].from(data) else { return }
        
        for item in arr {
            let newRealmItem = List(from: item)
            
            StorageManadger.saveObject(newRealmItem)
        }
    }
    
    static func importFrom(json: String) {
        importFrom(json: json.jsonData)
    }
    
    static func exportRealmData() -> [CodableWorkItem]? {
        let results = realm.objects(List.self)
        
        var items = [CodableWorkItem]()
        
        for item in results {
            items.append(item.workItem)
        }
        
        return items
    }
}
