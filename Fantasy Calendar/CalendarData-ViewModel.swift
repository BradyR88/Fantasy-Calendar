//
//  CalendarData-ViewModel.swift
//  Fantasy Calendar
//
//  Created by Brady Robshaw on 7/11/22.
//

import Foundation

@MainActor class CaledarDataViewModel: ObservableObject {
    @Published private(set) var calenderData: [Calendar] = [] {
        didSet {
            save()
        }
    }
    
    private(set) var selectedCalendar: Calendar {
        get {
            return calenderData.first(where: { $0.id.uuidString == navItemSelected }) ?? Calendar.example[0]
        }
        set {
            let index = calenderData.firstIndex(where: { $0.id.uuidString == navItemSelected })
            
            if index != nil {
                calenderData[index!] = newValue
            } else {
                print("Index not found for selected calandar")
            }
        }
    }
    private(set) var selectedEvent: Event {
        get {
            return selectedCalendar.events.first(where: { $0.id.uuidString == navEvent}) ?? Event.example
        }
        set {
            let index = selectedCalendar.events.firstIndex(where: { $0.id.uuidString == navEvent })
            
            if index != nil {
                selectedCalendar.events[index!] = newValue
            } else {
                print("Index not found for selected event")
            }
        }
    }
    
    private(set) var navItemSelected: String? = UserDefaults.standard.string(forKey: "navItemSelected")
    @Published private(set) var navEvent: String? = UserDefaults.standard.string(forKey: "navEvent")
    private let savePath = FileManager.documentsDirectory.appendingPathComponent("SavedCalender")
    
    func loadData() async {
        do {
            let data = try Data(contentsOf: savePath)
            calenderData = try JSONDecoder().decode([Calendar].self, from: data)
        } catch {
            calenderData = []
        }
    }
    
    func save() {
        do {
            let data = try JSONEncoder().encode(calenderData)
            try data.write(to: savePath)
        } catch {
            print("there was an error saving the data")
        }
    }
    
    func deleteCalendar(at offsets: IndexSet?) {
        if offsets != nil {
            calenderData.remove(atOffsets: offsets!)
        }
    }
    
    func createNewCalendar(name: String) {
        var new = Calendar(name: name)
        new.newEvent()
        
        calenderData.append(new)
    }
    
    func loadPreviewData() {
        calenderData = Calendar.example
    }
    
    func setCalendarTo(_ calendar: Calendar) {
        navItemSelected = calendar.id.uuidString
        UserDefaults.standard.set(navItemSelected, forKey: "navItemSelected")
        
        // set a resunabal defal event seletion
        if selectedCalendar.events.first(where: { $0.id.uuidString == navEvent}) == nil {
            navEvent = selectedCalendar.events.first?.id.uuidString
        }
        
    }
    
    func deselectCalendar() {
        navItemSelected = nil
        UserDefaults.standard.set(navItemSelected, forKey: "navItemSelected")
    }
    
    func newEvent() {
        selectedCalendar.newEvent()
        let newID = selectedCalendar.events.last?.id.uuidString ?? nil
        if newID != nil {
            navEvent = newID
            UserDefaults.standard.set(navEvent, forKey: "navEvent")
        }
    }
    
    func navToEvent(_ event: Event) {
        navEvent = event.id.uuidString
        UserDefaults.standard.set(navEvent, forKey: "navEvent")
    }
    
    func deleteEvent(at offsets: IndexSet?) {
        if offsets != nil {
            selectedCalendar.events.remove(atOffsets: offsets!)
        }
    }
    
    func editSelectedEvent(_ newEvent: Event) {
        selectedEvent = newEvent
    }
}
