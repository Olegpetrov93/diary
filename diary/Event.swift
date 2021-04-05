//
//  Event.swift
//  diary
//
//  Created by Oleg on 4/4/21.
//

import Foundation
import RealmSwift

struct Event {
    
    let list: List

    let bw: Float = 1
    let bofset: Float = 0.001
    
    var bofSetValue: Float
    var bwValue: Float
    
    let serialNumber : Float
    
    var y0: Float
    var y1: Float
   
    var x0: Float {
        get {
            if bwValue == 0 {
                return bofSetValue * bofset
            } else {
                return bofSetValue * bofset + (bw / (bwValue + 1) * serialNumber)
            }
        }
    }
    
    var x1: Float {
        get {
            if bwValue == 0 {
                return bw - bofSetValue * bofset
            } else {
                return (bw) / (bwValue + 1) + (bw / (bwValue + 1) * serialNumber) - bofSetValue * bofset
            }
        }
    }
        
    static func createEvent(filtredList: Results<List>?, day: Date) -> [Event]? {
        var createEvents : [Event] = []
        
        guard let filtredList = filtredList, !filtredList.isEmpty else { return createEvents }
        
        var bofSetVal: Float
        var bwVal: Float
        
        var maxValue = Float(Calendar.current.component(.hour, from: (filtredList.first?.dateFinish)!))
        var end = 0
        
        var serialNumberVal : Float
        
        for (index, currentItem) in filtredList.enumerated() {
            bofSetVal = 0
            maxValue = max(maxValue, currentItem.createHourFinish(toDay: day))
            if currentItem.createHourFinish(toDay: day) == maxValue {
                end = index
            } else {
                for itemIndex in end...index-1 {
                    if filtredList[itemIndex].createHourFinish(toDay: day) > filtredList[index].createHourFinish(toDay: day) {
                        bofSetVal += 1
                    }
                }
            }
            
            var previosValue: Int
            var nextValue: Int
            
            var previosIndex: Int
            var nextIndex: Int
            
            if index == filtredList.count-1 {
                nextValue = 0
            } else {
                nextIndex = index + 1
                nextValue = 0
                while nextIndex < filtredList.count
                        && currentItem.createHourStart(toDay: day) == filtredList[nextIndex].createHourStart(toDay: day) {
                    nextValue += 1
                    nextIndex += 1
                }
            }
            
            if index == 0 {
                previosValue = 0
            } else {
                previosIndex = index - 1
                previosValue = 0
                while previosIndex >= 0 &&
                        currentItem.createHourStart(toDay: day) == filtredList[previosIndex].createHourStart(toDay: day) {
                    previosIndex -= 1
                    previosValue += 1
                }
            }
            
            bwVal = Float(previosValue + nextValue)
            if bwVal == 0 {
                serialNumberVal = 0
            } else {
                serialNumberVal = bwVal - Float(nextValue)
            }
            
            createEvents.append(Event(list: currentItem,
                                     bofSetValue: bofSetVal,
                                     bwValue: bwVal,
                                     serialNumber: serialNumberVal,
                                     y0: currentItem.createHourStart(toDay: day),
                                     y1: currentItem.createHourFinish(toDay: day)))
        }
        
        return createEvents
    }
}
