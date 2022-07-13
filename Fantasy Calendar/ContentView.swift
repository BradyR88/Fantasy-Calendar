//
//  ContentView.swift
//  Fantasy Calendar
//
//  Created by Brady Robshaw on 7/11/22.
//

import SwiftUI

struct ContentView: View {
    @EnvironmentObject var viewModel: CaledarDataViewModel
    
    @State private var searchText = ""
    @State private var isMackingNewCalandar = false
    @State private var newCalandarName = ""
    @State private var isDeleteAlert = false
    @State private var indexSetToDelete: IndexSet? = nil
    @State private var isNavActive = false
    
    var body: some View {
        NavigationView {
            VStack {
                List{
                    Section {
                        ForEach(filteredCalandars) { calendar in
                            Button {
                                isNavActive = true
                                viewModel.setCalendarTo(calendar)
                            } label: {
                                HStack {
                                    VStack(alignment: .leading) {
                                        Text(calendar.name)
                                            .font(.title)
                                        
                                        if calendar.tags.isEmpty {
                                            Text("No Tags")
                                                .font(.caption)
                                        } else {
                                            Text(calendar.tags.joined(separator: ", "))
                                                .font(.caption)
                                        }
                                    }
                                    .foregroundColor(.primary)
                                    
                                    Spacer()
                                    
                                    Image(systemName: "chevron.right")
                                        .foregroundColor(.secondary)
                                        .accessibilityHidden(true)
                                }
                            }
                        }
                        .onDelete { indexSet in
                            indexSetToDelete = indexSet
                            isDeleteAlert = true
                        }
                    }
                    
                    Section {
                        Button {
                            isMackingNewCalandar = true
                        } label: {
                            HStack {
                                Image(systemName: "calendar.badge.plus")
                                Text("Add new calendar")
                            }
                            .foregroundColor(.primary)
                        }
                    }
                }
                .listStyle(.insetGrouped)
                .navigationTitle("Calendar List")
                .searchable(text: $searchText, prompt: "Search for a calendar")
                .toolbar {
                    Button {
                        isMackingNewCalandar = true
                    } label: {
                        Image(systemName: "calendar.badge.plus")
                            .foregroundColor(.primary)
                    }
                    
                }
                .alert("New Calendar", isPresented: $isMackingNewCalandar, actions: {
                    TextField("Calendar name", text: $newCalandarName)
                    
                    Button("Create") {viewModel.createNewCalendar(name: newCalandarName)}
                    Button("Cancel", role: .cancel, action: {})
                }, message: {
                    Text("Please enter the name of your new calendar.")
                })
                .alert("Delete this Calendar?", isPresented: $isDeleteAlert) {
                    Button("Delete") {
                        viewModel.createNewCalendar(name: newCalandarName)
                        indexSetToDelete = nil
                    }
                    Button("Cancel", role: .cancel, action: {})
                }
                
                
                NavigationLink(isActive: $isNavActive, destination: {CalendarView()}, label: {})
                    .hidden()
                    .accessibilityHidden(true)
            }
        }
    }
    
    var filteredCalandars: [Calendar] {
        var filter: [Calendar] = []
        
        if searchText.isEmpty {
            filter = viewModel.calenderData
        } else {
            filter = viewModel.calenderData.filter { $0.name.localizedCaseInsensitiveContains(searchText)}
        }
        
        return filter
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        let viewModel = CaledarDataViewModel()
        viewModel.loadPreviewData()
        
        return ContentView().environmentObject(viewModel)
    }
}
