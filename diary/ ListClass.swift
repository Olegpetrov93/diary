//
//   ListClass.swift
//  diary
//
//  Created by Oleg on 3/30/21.
//

import UIKit


struct List {
    
    var id: Int
    var dateStart: Date?
    var dateFinish: Date?
    var name: String
    var description: String
    
    static let dateFormatter: DateFormatter = {
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = .full
        return dateFormatter
    }()
    
    
    static let inputsDescription = ["Завтрак", "Обед", "Полдник", "Ужин"]
    
    static func getList() -> [List] {
        
        var toDoList: [List] = []
        
        var id = 0
        
        for f in inputsDescription {
            
            toDoList.append(List(id: id, dateStart: Date("2014-06-06") , dateFinish: Date("2014-06-04"), name: f, description: f))
            id += 1
        }
        
        return toDoList
    }
    
}
