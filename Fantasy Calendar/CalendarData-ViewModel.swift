//
//  CalendarData-ViewModel.swift
//  Fantasy Calendar
//
//  Created by Brady Robshaw on 7/11/22.
//

import Foundation

class CaledarDataViewModel: ObservableObject {
    @Published var calanderData: [Calendar] = []
    
    private let savePath = FileManager.documentsDirectory.appendingPathComponent("SavedCalender")
    
    func loadData() async {
        do {
            let data = try Data(contentsOf: savePath)
            calanderData = try JSONDecoder().decode([Calendar].self, from: data)
        } catch {
            calanderData = []
        }
    }
}
