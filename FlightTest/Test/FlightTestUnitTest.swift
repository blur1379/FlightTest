//
//  FlightTestUnitTest.swift
//  FlightTest
//
//  Created by Mohammad Blur on 2/17/23.
//

import XCTest
@testable import FlightTest
final class FlightTestUnitTest: XCTestCase {
//TODO: test the network
    var network = Network()
    var needHelpViewModel = NeedHelpViewModel()
    func testCallURL() async throws {
            
        let response = await network.callURL(urlStr: "https://client-configuration.stage.sindibad.app/api/ccs/config/ios-dev") as Result<NeedHelpModel, Error>
        switch response {
        case .success(let success):
            needHelpViewModel.needHelpData = success
        case .failure(let failure):
            print(failure)
        }
        XCTAssertFalse(needHelpViewModel.needHelpData == nil, "Response should not be empty")
    }
//TODO: test call
    func testCallNumbers() async{
        await needHelpViewModel.GetNeedHelp()
        let numbers = needHelpViewModel.getNumberWithWeight()
        
        var count = 0
        for number in (needHelpViewModel.needHelpData?.result?.config?.pages[0].items.first(where: {$0.key == "Call"})?.action as! CallActionModel).numbers {
            count += number.weight
        }
        if (needHelpViewModel.needHelpData?.result?.config?.pages[0].items.first(where: {$0.key == "Call"})?.action as! CallActionModel).numbers.first(where: {$0.weight < 2}) != nil{
            count += count
        }
        print(numbers)
        print(numbers.count)
        XCTAssertTrue(numbers.count == count)
        
    }
}
