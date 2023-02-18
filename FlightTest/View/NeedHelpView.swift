//
//  NeedHelpView.swift
//  FlightTest
//
//  Created by Mohammad Blur on 2/18/23.
//

import SwiftUI

struct NeedHelpView: View {
    @Binding var pageItems: [PageItemModel]
    @ObservedObject var needHelpViewModel : NeedHelpViewModel
    var body: some View {
        VStack{
            HStack{
                Text("Need Help?")
                    .font(.title)
                    .bold()
                    .padding(.leading, 12)
                Spacer()
            }
           
            ForEach(pageItems) { item in
                NeedHelpItemCell(pageitem: item, needHelpViewModel: needHelpViewModel)
            }
            Spacer()
        }.animation(.easeIn, value: pageItems.count)
    }
}

struct NeedHelpView_Previews: PreviewProvider {
    @State static var pageItems:[PageItemModel] = [PageItemModel(show: true, key: "Call", title: "Make a Call", titleLocale: "Make a Call", icon: "https://i.ibb.co/9twzYFD/Phone.png",action: CallActionModel(type: "Call", numbers: [NumberModel(number: "+987802771166", weight: 8),NumberModel(number: "+987739004433", weight: 2),NumberModel(number: "+987739004422", weight: 1)], specialNumber: "6522"))]
    static var previews: some View {
        NeedHelpView(pageItems: $pageItems, needHelpViewModel: NeedHelpViewModel())
    }
}
