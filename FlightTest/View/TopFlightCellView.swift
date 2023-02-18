//
//  TopFlightCellView.swift
//  FlightTest
//
//  Created by Mohammad Blur on 2/18/23.
//

import SwiftUI

struct TopFlightCellView: View {
    //MARK: -PROPERTIES
    var nameOfOrigin: String
    var nameOfDestination: String
    //MARK: -VIEW
    var body: some View {
        VStack{
            Image("\(nameOfDestination)")
                .resizable()
                .clipShape(RoundedRectangle(cornerRadius: 12))
                .overlay {
                    VStack{
                        Spacer()
                        HStack{
                            Text("\(nameOfOrigin) to")
                                .font(.system(size: 12))
                                .foregroundColor(.white)
                                .multilineTextAlignment(.trailing)
                            Spacer()
                        }
                        HStack{
                            Text("\(nameOfDestination)")
                                .font(.system(size: 20))
                                .bold()
                                .foregroundColor(.white)
                            Spacer()
                        }
                    }.padding()
                }
        }

    }
}
//MARK: -PREVIEW
struct TopFlightCellView_Previews: PreviewProvider {
    static var previews: some View {
        TopFlightCellView(nameOfOrigin: "Istanbul", nameOfDestination: "Tehran")
            .frame(width: 200,height: 100)
    }
}
