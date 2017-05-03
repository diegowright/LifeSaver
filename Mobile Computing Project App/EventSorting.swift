//
//  EventSorting.swift
//  Mobile Computing Project App
//
//  Created by Diego Wright on 5/3/17.
//  Copyright © 2017 Robin Stewart. All rights reserved.
//

import Foundation

class EventSorting {
    class func sortByDate(template: Template) -> ([Date], [Int]) {
        // Load in all events associated to
        let templateEvents = template.event!
        
        // Create date formatter
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy MM dd"
        dateFormatter.locale = NSLocale.autoupdatingCurrent
        
        // Create variables
        var events:[Event] = []
        var oldestDate:Date?
        let currentDate:Date = Date()
        
        // Get oldest date from events
        for el in templateEvents {
            let event = el as! Event
            let eventDates = event.datetimes!
            var recordDate:Date?
            
            // Check if entity has a date associated
            if eventDates.count != 0 {
                // Event had datetime attribute so use that time
                let dateTimeValue = Array(eventDates)[0] as! EventDateTimeValue // just use first value
                recordDate = dateTimeValue.datetime! as Date
            } else {
                // No date associated by attribute type so use event creation time
                recordDate = event.dateCreated! as Date
            }
            
            if let old = oldestDate {
                // Compare them
                if old.compare(recordDate!) == .orderedDescending {
                    oldestDate = recordDate!
                }
            } else {
                oldestDate = recordDate!
            }
            events.append(event)
        }
        print("Oldest date: ", dateFormatter.string(from: oldestDate!))
        
        // Create list of weeks from oldest date till current date
        var weekList:[Date] = [oldestDate!]
        let calendar = Calendar.current
        while weekList[weekList.count - 1] <= currentDate {
            let newDate = calendar.date(byAdding: .day, value: 7, to: weekList[weekList.count - 1])!
            weekList.append(newDate)
        }
        print("Weeklist: ", weekList)
        
        // Get count of events sorted into week long bins
        var eventCount:[Int] = []
        for _ in weekList {
            // make count list as long as week list
            eventCount.append(0)
        }
        
        // Get counts of events by week
        for event in events {
            var recordDate:Date?
            let eventDates = event.datetimes!
            // Check if entity has a date associated
            if eventDates.count != 0 {
                // Event had datetime attribute so use that time
                let dateTimeValue = Array(eventDates)[0] as! EventDateTimeValue // just use first value
                recordDate = dateTimeValue.datetime! as Date
            } else {
                // No date associated by attribute type so use event creation time
                recordDate = event.dateCreated! as Date
            }
            
            for idx in 0...weekList.count - 1 {
                let weekStart:Date = weekList[idx]
                let weekEnd = calendar.date(byAdding: .day, value: 7, to: weekStart)!
                if weekStart <= recordDate! && recordDate! < weekEnd {
                    eventCount[idx] += 1
                }
            }
        }
        print("Eventcount: ", eventCount)
        
        // Return weeklist and eventCount
        return (weekList, eventCount)
    }
}
