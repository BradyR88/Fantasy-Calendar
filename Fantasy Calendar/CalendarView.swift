//
//  CalendarView.swift
//  Fantasy Calendar
//
//  Created by Brady Robshaw on 7/12/22.
//

import SwiftUI

struct CalendarView: View {
    @EnvironmentObject var viewModel: CaledarDataViewModel
    
    // top half - the event picker
    @State private var searchText = ""
    
    // bottome half - the data vewer
    @State private var editMode = false
    
    var body: some View {
        VStack {
            List {
                Section {
                    ForEach(viewModel.selectedCalendar.events) { event in
                        Button {
                            viewModel.navToEvent(event)
                        } label: {
                            Text(event.name)
                        }

                    }
                    .onDelete { viewModel.deleteEvent(at: $0)}
                }
                
                Button {
                    addEvent()
                } label: {
                    HStack {
                        Image(systemName: "note.text.badge.plus")
                        Text("Add event")
                    }
                    .foregroundColor(.primary)
                    .accessibilityHidden(true)
                }
                .accessibilityHint("Add event")

            }
            .listStyle(.insetGrouped)
            .searchable(text: $searchText, prompt: "Search for an event")
            .frame(height: 375)
            
            // --------------- this is the split of the top and bottom section
            
            if editMode {
                EditEventView(editMode: $editMode)
            } else {
                ReadEventView(editMode: $editMode)
            }
            
        }
        .navigationTitle(viewModel.selectedCalendar.name)
        .navigationBarTitleDisplayMode(.inline)
        .onDisappear { viewModel.deselectCalendar() }
    }
    
    var filteredEvents: [Event] {
        var filter: [Event] = []
        
        if searchText.isEmpty {
            filter = viewModel.selectedCalendar.events
        } else {
            filter = viewModel.selectedCalendar.events.filter { $0.name.localizedCaseInsensitiveContains(searchText)}
        }
        
        return filter.sorted()
    }
    
    func addEvent() {
        editMode = true
        viewModel.newEvent()
    }    
}

struct CalendarView_Previews: PreviewProvider {
    static var previews: some View {
        let viewModel = CaledarDataViewModel()
        viewModel.loadPreviewData()
        
        return NavigationView {
            CalendarView().environmentObject(viewModel)
                .navigationBarTitleDisplayMode(.inline)
        }
    }
}
