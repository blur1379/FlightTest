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
    
    
    func testCallURL() async throws {
            
        let response = try await network.callURL(urlStr: "https://client-configuration.stage.sindibad.app/api/ccs/config/ios-dev")
            XCTAssertFalse(response.isEmpty, "Response should not be empty")
    }
//TODO: test call

}
