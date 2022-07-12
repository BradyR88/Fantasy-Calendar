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
    
    static let example: [Calendar] = Bundle.main.decode("ExampleData.json")
}

struct Event: Codable, Identifiable {
    var id: UUID
    var name: String
    var date: Date
    var discription: String
    var tags: [String]
    
    static let example = Event(id: UUID(), name: "Test Event", date: Date(), discription: "This is test data!", tags: ["test", "example", "fun"])
}

struct DateRange: Codable, Identifiable {
    var id: UUID
    var name: String
    var dateStart: Date
    var dateStop: Date
    var discription: String
    var tags: [String]
    
    static let example = DateRange(id: UUID(), name: "Test Event", dateStart: Date(), dateStop: Date(), discription: "This is test data!", tags: ["test", "example", "fun"])
}

extension Calendar {
    init(name: String) {
        id = UUID()
        self.tags = []
        self.events = []
        self.dateRanges = []
        
        if name.isEmpty {
            self.name = "New Calandar"
        } else {
            self.name = name
        }
    }
}
