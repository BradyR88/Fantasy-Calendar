//
//  ContentView.swift
//  Fantasy Calendar
//
//  Created by Brady Robshaw on 7/11/22.
//

import SwiftUI

struct ContentView: View {
    @EnvironmentObject var viewModel: CaledarDataViewModel
    
    @State var searchText = ""
    @State var isMackingNewCalandar = false
    @State var newCalandarName = ""
    
    var body: some View {
        NavigationView {
            List(filteredCalandars) { calendar in
                
                Section {
                    NavigationLink {
                        Text(calendar.name)
                    } label: {
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
                    }
                }
                
                Section {
                    Button {
                        //
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
                        
                        Button("Create", action: {viewModel.createNewCalendar(name: newCalandarName)})
                        Button("Cancel", role: .cancel, action: {})
                    }, message: {
                        Text("Please enter the name of your new calendar.")
                    })
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
