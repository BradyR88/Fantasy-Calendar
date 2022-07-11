//
//  ContentView.swift
//  Fantasy Calendar
//
//  Created by Brady Robshaw on 7/11/22.
//

import SwiftUI

struct ContentView: View {
    @EnvironmentObject var calandarData: CaledarDataViewModel
    
    var body: some View {
        VStack {
            Text("Hello, world!")
                .padding()
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
