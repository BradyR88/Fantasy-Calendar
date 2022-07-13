//
//  CalendarView.swift
//  Fantasy Calendar
//
//  Created by Brady Robshaw on 7/12/22.
//

import SwiftUI

struct CalendarView: View {
    @EnvironmentObject var viewModel: CaledarDataViewModel
    
    @State private var editMode = false
    
    var body: some View {
        VStack {
            ZStack {
                Color.blue
                    .frame(height: 400)
                Text("This is a cool time line!!")
            }
            
            
            HStack {
                Spacer()
                
                Image(systemName: "pencil.circle")
                    .font(.title)
                    .padding(.trailing, 5)
                    .accessibilityRemoveTraits(.isImage)
                    .accessibilityAddTraits(.isButton)
                    .accessibilityHint("activate edit mode")
                    .onTapGesture { editMode = true }
            }
            
            Spacer()
        }
        .navigationTitle(viewModel.selectedCalendar?.name ?? "No Name")
        .navigationBarTitleDisplayMode(.inline)
        .onDisappear { viewModel.deselectCalendar() }
    }
}

struct CalendarView_Previews: PreviewProvider {
    static var previews: some View {
        let viewModel = CaledarDataViewModel()
        viewModel.loadPreviewData()
        
        return NavigationView {
            CalendarView().environmentObject(viewModel)
                .navigationTitle("Example")
                .navigationBarTitleDisplayMode(.inline)
        }
    }
}
