//
//  CalendarData-ViewModel.swift
//  Fantasy Calendar
//
//  Created by Brady Robshaw on 7/11/22.
//

import Foundation

@MainActor class CaledarDataViewModel: ObservableObject {
    @Published private(set) var calanderData: [Calendar] = []
    
    private let savePath = FileManager.documentsDirectory.appendingPathComponent("SavedCalender")
    
    func loadData() async {
        do {
            let data = try Data(contentsOf: savePath)
            calanderData = try JSONDecoder().decode([Calendar].self, from: data)
        } catch {
            calanderData = []
        }
    }
    
    func save() {
        do {
            let data = try JSONEncoder().encode(calanderData)
            try data.write(to: savePath)
        } catch {
            print("there was an error saving the data")
        }
    }
    
    func createNewCalendar(name: String) {
        let new = Calendar(name: name)
        
        calanderData.append(new)
    }
    
    func loadPreviewData() {
        calanderData = Calendar.example
    }
}
