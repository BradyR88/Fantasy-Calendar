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
    
    var body: some View {
        NavigationView {
            List(filteredCalandars) { calandar in
                NavigationLink {
                    Text(calandar.name)
                } label: {
                    VStack(alignment: .leading) {
                        Text(calandar.name)
                            .font(.title)
                        Text(calandar.tags.joined(separator: ", "))
                            .font(.caption)
                    }
                }
            }
            .navigationTitle("Calandar List")
            .searchable(text: $searchText, prompt: "Search for a calandaer")
            .toolbar {
                Button {
                    // add new calandar
                } label: {
                    Image(systemName: "calendar.badge.plus")
                        .foregroundColor(.primary)
                }

            }
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
