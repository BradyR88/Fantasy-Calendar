//
//  ReadEventView.swift
//  Fantasy Calendar
//
//  Created by Brady Robshaw on 7/18/22.
//

import SwiftUI

struct ReadEventView: View {
    @EnvironmentObject var viewModel: CaledarDataViewModel
    
    @Binding var editMode: Bool
    
    var body: some View {
        VStack(alignment: .leading) {
            HStack {
                Text(viewModel.selectedEvent.name)
                    .font(.title)
                
                Spacer()
                
                Image(systemName: "pencil.circle")
                    .font(.title)
                    .foregroundColor(editMode ? .green : .primary)
                    .padding(.trailing)
                    .accessibilityRemoveTraits(.isImage)
                    .accessibilityAddTraits(.isButton)
                    .accessibilityHint("activate edit mode")
                    .onTapGesture { withAnimation {editMode.toggle()}}
            }
            .padding(.bottom, 2)
            
            Text(viewModel.selectedEvent.date.formatted(date: .abbreviated, time: .omitted)) +
            Text("  \(viewModel.selectedCalendar.tags.joined(separator: ", "))")
            
            ScrollView(.vertical, showsIndicators: true) {
                Text(viewModel.selectedEvent.discription)
            }
        }
        .padding(.leading)
    }
}

struct ReadEventView_Previews: PreviewProvider {
    static var previews: some View {
        let viewModel = CaledarDataViewModel()
        viewModel.loadPreviewData()
        
        return ReadEventView(editMode: .constant(false)).environmentObject(viewModel)
    }
}
