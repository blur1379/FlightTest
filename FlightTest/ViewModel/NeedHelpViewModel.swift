//
//  NeedHelpViewModel.swift
//  FlightTest
//
//  Created by Mohammad Blur on 2/17/23.
//

import Foundation
import Combine

protocol NeedHelpViewModelProtocol : ObservableObject{
    func GetNeedHelp() async
    func setPageItems()
    func getNumberForCall() -> String
    func getNumberWithWeight() -> [String]
    func getWhatsappNumber()-> String
    func getWhatsappMessage()-> String
    func getFAQAdress() -> String
}


class NeedHelpViewModel: NeedHelpViewModelProtocol {
    //TODO: set publisher and call url for need help
    @Published var needHelpData : NeedHelpModel? = nil
    @Published var error: Error? = nil
    @Published var pageItems: [PageItemModel] = []
    
    func GetNeedHelp() async{
        let result = await Network().callURL(urlStr: "https://client-configuration.stage.sindibad.app/api/ccs/config/ios-dev") as Result<NeedHelpModel,Error>
        switch result {
        case .success(let needHelp):
            DispatchQueue.main.async {
                self.needHelpData = needHelp
                self.setPageItems()
            }
           
        case .failure(let failure):
            error = failure
        }
    }
    
    func setPageItems(){
         pageItems = needHelpData?.result?.config?.pages.first?.items ?? []
        
    }
    
    // call number operation
    func getNumberForCall()-> String{
        let selectedNumber = getNumberWithWeight().shuffled().randomElement()
        return selectedNumber ?? ""
    }
    func getNumberWithWeight() -> [String]{
        var numbers: [String] = []
        var numbersModel : [NumberModel]=[]
        let action = pageItems.first(where: {$0.key == "Call"})?.action
        if action is CallActionModel{
            numbersModel = (action as! CallActionModel).numbers
        }
        
       
        if numbersModel.count > 0 {
            for model in numbersModel {
                numbers.append(contentsOf: repeatElement(model.number, count: model.weight))
            }
        }
        if numbersModel.first(where: {$0.weight < 2 }) != nil{
            numbers.append(contentsOf: repeatElement((action as! CallActionModel).specialNumber!, count: numbers.count))
        }
        return numbers
    }
    func getWhatsappNumber()-> String{
        var whatsappNumber : String = ""
        var whatsappNumbers: [String] = []
        let action = pageItems.first(where: {$0.key == "Whatsapp"})?.action
        if action is WhatsAppActionModel{
            whatsappNumbers = (action as! WhatsAppActionModel).numbers
        }
        whatsappNumber = whatsappNumbers.randomElement() ?? ""
        return whatsappNumber
    }
    func getWhatsappMessage()-> String {
        var message : String = ""
        let action = pageItems.first(where: {$0.key == "Whatsapp"})?.action
        if action is WhatsAppActionModel{
            message = (action as! WhatsAppActionModel).message ?? ""
        }
        return message
    }
    
    
    func getFAQAdress() -> String{
        var url : String = ""
        let action = pageItems.first(where: {$0.key == "FAQ"})?.action
        if action is FAQActionModel{
            url = (action as! FAQActionModel).url ?? ""
        }
        return url
    }
    
    
}
