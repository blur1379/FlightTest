//
//  ContentView.swift
//  FlightTest
//
//  Created by Mohammad Blur on 2/17/23.
//

import SwiftUI
import Lottie
struct ContentView: View {
    //MARK: Properties
    var network = Network()
    @StateObject var needHelpViewModel : NeedHelpViewModel = NeedHelpViewModel()
    @State var isShowMoreEnabele: Bool = true
    @State private var isShowingErrorForCallApi  = false
    //MARK: View
    var body: some View {
        ZStack(alignment: .top) {
            // view for top flight
            FlightView()
            
            // floating view
            VStack(spacing: 0){
                Spacer(minLength: isShowMoreEnabele ? 168 : 336)
                
                // show more section
                HStack{
                    Spacer()
                    VStack(spacing:0){
                        Image(systemName: "chevron.up").foregroundColor(.black)
                            .padding(8)
                            .rotationEffect(Angle(degrees: isShowMoreEnabele ? 180 : 0))
                        Text("Show More")
                    }
                    Spacer()
                }
               .padding(.bottom, 20)
               .background(.white)
               .onTapGesture {
                   isShowMoreEnabele.toggle()
               }
                // show error or need help
                if isShowingErrorForCallApi{
                VStack{
                    Spacer()
                    LottieView(lottieFile: "notConnectionLottie ")
                    Spacer()
                }.background(Color.white)
                   
                }else{
                    // need help section
                    NeedHelpView(pageItems: $needHelpViewModel.pageItems, needHelpViewModel: needHelpViewModel)
                        .background(.white)
                }
                
                
            }
            

           
        }
        .animation(.easeIn, value: isShowMoreEnabele)
       
        .onAppear{
            Task{
                await needHelpViewModel.GetNeedHelp()
                if needHelpViewModel.needHelpData == nil || needHelpViewModel.error != nil {
                    isShowingErrorForCallApi = true
                }else{
                    isShowingErrorForCallApi = false
                }

            }
           
        }
        
       
    }
}
//MARK: Preview
struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

