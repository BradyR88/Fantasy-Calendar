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
            List(filteredCalandars) { calandar in
                
                Section {
                    NavigationLink {
                        Text(calandar.name)
                    } label: {
                        VStack(alignment: .leading) {
                            Text(calandar.name)
                                .font(.title)
                            
                            if calandar.tags.isEmpty {
                                Text("No Tags")
                                    .font(.caption)
                            } else {
                                Text(calandar.tags.joined(separator: ", "))
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
                            Text("Add new calandar")
                        }
                        .foregroundColor(.primary)
                    }
                }
            }
            .listStyle(.insetGrouped)
            .navigationTitle("Calandar List")
            .searchable(text: $searchText, prompt: "Search for a calandar")
            .toolbar {
                Button {
                    isMackingNewCalandar = true
                } label: {
                    Image(systemName: "calendar.badge.plus")
                        .foregroundColor(.primary)
                }

            }
            .alert("New Calandar", isPresented: $isMackingNewCalandar, actions: {
                        TextField("Calandar name", text: $newCalandarName)
                        
                        Button("Create", action: {viewModel.createNewCalendar(name: newCalandarName)})
                        Button("Cancel", role: .cancel, action: {})
                    }, message: {
                        Text("Please enter the name of your new calandar.")
                    })
        }
    }
    
    var filteredCalandars: [Calendar] {
        var filter: [Calendar] = []
        
        if searchText.isEmpty {
            filter = viewModel.calanderData
        } else {
            filter = viewModel.calanderData.filter { $0.name.localizedCaseInsensitiveContains(searchText)}
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
