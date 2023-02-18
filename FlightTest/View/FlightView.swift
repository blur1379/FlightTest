//
//  FlightView.swift
//  FlightTest
//
//  Created by Mohammad Blur on 2/18/23.
//

import SwiftUI

struct FlightView: View {
    //MARK: -Properties
    
    //MARK: -VIEW
    var body: some View {
        VStack(spacing: 0){
            HStack{
                TopFlightCellView(nameOfOrigin: "Tehran", nameOfDestination: "Istanbul")
                TopFlightCellView(nameOfOrigin: "Istanbul", nameOfDestination: "Tehran")
                    
            }.frame(height: 150)
                .padding(8)
            HStack{
                TopFlightCellView(nameOfOrigin: "Tehran", nameOfDestination: "Beirut")
                TopFlightCellView(nameOfOrigin: "Tehran", nameOfDestination: "Baku")
            }.frame(height: 150)
                .padding(8)
            Spacer()
        }.padding(8)
    }
}
//MARK: -PREVIEW
struct FlightView_Previews: PreviewProvider {
    static var previews: some View {
        FlightView()
    }
}
