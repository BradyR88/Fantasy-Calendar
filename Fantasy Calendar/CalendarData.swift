//
//  CalendarData.swift
//  Fantasy Calendar
//
//  Created by Brady Robshaw on 7/11/22.
//

import Foundation

struct Calendar: Codable, Identifiable {
    var id: UUID
    var name: String
    var tags: [String]
    var events: [Event]
    var dateRanges : [DateRange]
    
    init(name: String, tags: [String], events: [Event], dateRanges: [DateRange]) {
        id = UUID()
        self.name = name
        self.tags = tags
        self.events = events
        self.dateRanges = dateRanges
    }
}

struct Event: Codable, Identifiable {
    var id: UUID
    var name: String
    var date: Date
    var discription: String
    var tags: [String]
}

struct DateRange: Codable, Identifiable {
    var id: UUID
    var name: String
    var dateStart: Date
    var dateStop: Date
    var discription: String
    var tags: [String]
}
