//
//  ContentView.swift
//  FlightTest
//
//  Created by Mohammad Blur on 2/17/23.
//

import SwiftUI

struct ContentView: View {
    //MARK: Properties
    var network = Network()
    
    //MARK: View
    var body: some View {
        VStack {
            Image(systemName: "globe")
                .imageScale(.large)
                .foregroundColor(.accentColor)
           
            Text("Hello, world!")
        }
        .padding()
    }
}
//MARK: Preview
struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
