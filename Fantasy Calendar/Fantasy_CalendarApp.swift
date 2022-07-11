//
//  Fantasy_CalendarApp.swift
//  Fantasy Calendar
//
//  Created by Brady Robshaw on 7/11/22.
//

import SwiftUI

@main
struct Fantasy_CalendarApp: App {
    @StateObject var calinderData = CaledarDataViewModel()
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(calinderData)
                .task {
                    await calinderData.loadData()
                }
        }
    }
}
