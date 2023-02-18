//
//  NeedHelpItemCell.swift
//  FlightTest
//
//  Created by Mohammad Blur on 2/19/23.
//

import SwiftUI
import UIKit
struct NeedHelpItemCell: View {
    var pageitem : PageItemModel
    @ObservedObject var needHelpViewModel : NeedHelpViewModel
    @State private var isPresented = false
    var network = Network()
    var body: some View {
        HStack{
            network.downloadImage(urlStr: pageitem.icon)
                .frame(width: 30, height: 30, alignment: .center)
                .padding(.horizontal,12)
            Text(pageitem.title)
                .font(.system(size: 20))
                .bold()
                .foregroundColor(.black.opacity(0.65))
            
            Spacer()
        }
        .onTapGesture {
            switch pageitem.key{
            case "Call":
                if let url = URL(string: "tel://\(needHelpViewModel.getNumberForCall())") {
                    UIApplication.shared.open(url)
                }
            case "Whatsapp":
                if let url = URL(string: "https://wa.me/\(needHelpViewModel.getWhatsappNumber())?text=\(needHelpViewModel.getWhatsappMessage())") {
                    UIApplication.shared.open(url)
                }
            case "FAQ":
                isPresented = true
            default:
                return
            }
        }
        .sheet(isPresented: $isPresented) {
            NavigationView {
                WebView(url: URL(string: needHelpViewModel.getFAQAdress())!)
                    .navigationBarTitle("FAQ")
                    .navigationBarItems(trailing: Button("Close") {
                        isPresented = false
                    })
            }
        }
    }
}

struct NeedHelpItemCell_Previews: PreviewProvider {
    @StateObject static var viewModel = NeedHelpViewModel()
    static var previews: some View {
        NeedHelpItemCell(pageitem: PageItemModel(show: true, key: "Call", title: "Make a Call", titleLocale: "Make a Call", icon: "https://i.ibb.co/9twzYFD/Phone.png",action: CallActionModel(type: "Call", numbers: [NumberModel(number: "+987802771166", weight: 8),NumberModel(number: "+987739004433", weight: 2),NumberModel(number: "+987739004422", weight: 1)], specialNumber: "6522")), needHelpViewModel: viewModel)
    }
}
