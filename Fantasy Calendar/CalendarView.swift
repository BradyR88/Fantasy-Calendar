//
//  CalendarView.swift
//  Fantasy Calendar
//
//  Created by Brady Robshaw on 7/12/22.
//

import SwiftUI

struct CalendarView: View {
    @EnvironmentObject var viewModel: CaledarDataViewModel
    @State var calendar: Calendar
    
    var body: some View {
        Text(calendar.name)
            .padding()
    }
}

struct CalendarView_Previews: PreviewProvider {
    static var previews: some View {
        let viewModel = CaledarDataViewModel()
        viewModel.loadPreviewData()
        
        return CalendarView(calendar: Calendar.example[0]).environmentObject(viewModel)
    }
}
