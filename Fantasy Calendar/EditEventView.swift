//
//  EditEventView.swift
//  Fantasy Calendar
//
//  Created by Brady Robshaw on 7/15/22.
//

import SwiftUI

struct EditEventView: View {
    @EnvironmentObject var viewModel: CaledarDataViewModel
    
    @State private var event: Event = Event.example
    
    @Binding var editMode: Bool
    
    var body: some View {
        VStack {
            HStack {
                Button {
                    withAnimation {
                        editMode.toggle()
                    }
                } label: {
                    Text("Discard changes")
                        .foregroundColor(.red)
                        .bold()
                }
                .padding(.leading)
                
                Spacer()
                
                Button {
                    // save
                    withAnimation {
                        editMode.toggle()
                    }
                    
                    
                } label: {
                    Text("Save")
                        .foregroundColor(.green)
                        .bold()
                }
                .padding(.trailing)
            }
            
            Form {
                HStack {
                    Text("Event name:")
                    TextField("", text: $event.name)
                }
                DatePicker("Event Date:", selection: $event.date, displayedComponents: .date)
                
                Section {
                    TextEditor(text: $event.discription)
                } header: {
                    Text("Discription")
                }
            }
        }
        .onAppear { event = viewModel.selectedEvent }
    }
}

struct EditEventView_Previews: PreviewProvider {
    static var previews: some View {
        let viewModel = CaledarDataViewModel()
        viewModel.loadPreviewData()
        
        return EditEventView(editMode: .constant(true)).environmentObject(viewModel)
    }
}
