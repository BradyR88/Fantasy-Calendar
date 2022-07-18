//
//  EditEventView.swift
//  Fantasy Calendar
//
//  Created by Brady Robshaw on 7/15/22.
//

import SwiftUI

struct EditEventView: View {
    @EnvironmentObject var viewModel: CaledarDataViewModel
    
    @State private var name = ""
    
    var body: some View {
        Form {
            Text("Event name")
            TextField("", text: $name)
        }
    }
}

struct EditEventView_Previews: PreviewProvider {
    static var previews: some View {
        EditEventView()
    }
}
