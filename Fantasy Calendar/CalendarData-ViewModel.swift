//
//  CalendarData-ViewModel.swift
//  Fantasy Calendar
//
//  Created by Brady Robshaw on 7/11/22.
//

import Foundation

@MainActor class CaledarDataViewModel: ObservableObject {
    @Published private(set) var calenderData: [Calendar] = []
    @Published private(set) var selectedCalendar: Calendar? = nil
    
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
        let new = Calendar(name: name)
        
        calenderData.append(new)
    }
    
    func loadPreviewData() {
        calenderData = Calendar.example
        selectedCalendar = Calendar.example[0]
    }
    
    func setCalendarTo(_ calendar: Calendar) {
        selectedCalendar = calendar
    }
}
