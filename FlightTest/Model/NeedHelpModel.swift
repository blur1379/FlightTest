//
//  NeedHelpModel.swift
//  FlightTest
//
//  Created by Mohammad Blur on 2/17/23.
//

import Foundation
struct NeedHelpModel: Codable{
    //TODO: setup need help model
    let success : Bool
    let result: NeedHelpResultModel?
//    let error:
    
}
struct NeedHelpResultModel: Codable{
    let config: NeedHelpConfigModel?
}
struct NeedHelpConfigModel: Codable {
    var pages : [PageModel] = []
}
struct PageModel: Codable{
     var items : [PageItemModel] = []
}
struct PageItemModel : Identifiable{
    var id : UUID = UUID()
    let show : Bool
    let key : String
    let title : String
    let titleLocale : String
    let icon : String
    var action : ActionProtocol?
    enum CodingKeys: CodingKey {
        case show
        case key
        case title
        case titleLocale
        case icon
        case action
    }
    enum ParseError: Error {
        case notRecognizedType(Any)
    }
  
  
}
extension PageItemModel : Decodable{
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.show = try container.decode(Bool.self, forKey: .show)
        self.key = try container.decode(String.self, forKey: .key)
        self.title = try container.decode(String.self, forKey: .title)
        self.titleLocale = try container.decode(String.self, forKey: .titleLocale)
        self.icon = try container.decode(String.self, forKey: .icon)
        switch key {
        case "Call":
            self.action = try container.decodeIfPresent(CallActionModel.self, forKey: .action)
        case "Whatsapp":
            self.action = try container.decodeIfPresent(WhatsAppActionModel.self, forKey: .action)
        case "FAQ":
            self.action = try container.decodeIfPresent(FAQActionModel.self, forKey: .action)
        default:
            throw ParseError.notRecognizedType(key)
        }
       
    }
}
extension PageItemModel :Encodable{
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(show, forKey: .show)
        try container.encode(key, forKey: .key)
        try container.encode(title, forKey: .title)
        try container.encode(titleLocale, forKey: .titleLocale)
        try container.encode(icon, forKey: .icon)
        try container.encode(key, forKey: .key)
    }
}


protocol ActionProtocol: Codable{
    var type: String { get set }
}

struct CallActionModel: ActionProtocol {
    var type: String
    var numbers : [NumberModel] = []
    var specialNumber: String?
}
struct WhatsAppActionModel: ActionProtocol{
    var type: String
    var message: String?
    var numbers : [String] = []
}
struct FAQActionModel:ActionProtocol{
    var type: String
    var url : String?
    var title : String?
}
struct NumberModel: Codable{
    var number : String
    var weight : Int
}
