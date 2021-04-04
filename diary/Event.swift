//
//  Event.swift
//  diary
//
//  Created by Oleg on 4/4/21.
//

import Foundation
import RealmSwift

struct Event {
    
    let bw: Float = 1
    let bofset: Float = 0.01
    
    var bofsetValue: Float
    var bwValue: Float
    
    let serialNomber : Float
    
    var y0: Float
    var y1: Float
    var x0: Float {
        get {
            if bwValue == 0 {
                return bofsetValue * bofset
            } else {
                return bofsetValue * bofset + (bw / (bwValue + 1) * serialNomber)
            }
        }
    }
    var x1: Float {
        get {
            if bwValue == 0 {
                return bw - bofsetValue * bofset
            } else {
                return (bw) / (bwValue + 1) + (bw / (bwValue + 1) * serialNomber) - bofsetValue * bofset
            }
        }
    }
    
    let list: List
    
    
    static func createEvents(filtredList: Results<List>?, day: Date) -> [Event]? {
        
        var createvents : [Event] = []
        
        guard let filtredList = filtredList, !filtredList.isEmpty else { return createvents }
        
        var bofsetVal: Float
        var bwVal: Float
        
        var maxValue = Float(Calendar.current.component(.hour, from: (filtredList.first?.dateFinish)!))
        var end = 0
        
        var serialNomberVal : Float
        
        for (index, currentItem) in filtredList.enumerated() {
            bofsetVal = 0
            maxValue = max(maxValue, currentItem.createhourFinish(toDay: day))
            if currentItem.createhourFinish(toDay: day) == maxValue {
                end = index
            } else {
                for itemIndex in end...index-1 {
                    if filtredList[itemIndex].createhourFinish(toDay: day) > filtredList[index].createhourFinish(toDay: day) {
                        bofsetVal += 1
                    }
                }
            }
            
            var previosValue: Int
            var nexthValue: Int
            
            var previosIndex: Int
            var nextIndex: Int
            
            if index == filtredList.count-1 {
                nexthValue = 0
            } else {
                nextIndex = index + 1
                nexthValue = 0
                while nextIndex < filtredList.count
                        && currentItem.createhourStart(toDay: day) == filtredList[nextIndex].createhourStart(toDay: day) {
                    nexthValue += 1
                    nextIndex += 1
                }
            }
            
            if index == 0 {
                previosValue = 0
            } else {
                previosIndex = index - 1
                previosValue = 0
                while previosIndex >= 0 &&
                        currentItem.createhourStart(toDay: day) == filtredList[previosIndex].createhourStart(toDay: day) {
                    previosIndex -= 1
                    previosValue += 1
                }
            }
            
            bwVal = Float(previosValue + nexthValue)
            if bwVal == 0 {
                serialNomberVal = 0
            } else {
                serialNomberVal = bwVal - Float(nexthValue)
            }
            
            createvents.append(Event(bofsetValue: bofsetVal, bwValue: bwVal, serialNomber: serialNomberVal, y0: currentItem.createhourStart(toDay: day), y1: currentItem.createhourFinish(toDay: day), list: currentItem))
        }
        return createvents
    }
}
