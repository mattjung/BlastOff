//
//  Rocket+ViewModel+SuccessRate+Tests.swift
//  Tests iOS
//
//  Created by Matt Jung on 20/02/2021.
//

import XCTest
@testable import BlastOff

class Rocket_ViewModel_SuccessRate_Tests: XCTestCase {
    
    func test_success_rate_status() {
        let sut = SpaceX.Rocket.ViewModel.SuccessRate.status
        
        XCTAssertEqual(sut(-1), .red)
        XCTAssertEqual(sut(0), .red)
        XCTAssertEqual(sut(29), .red)
        XCTAssertEqual(sut(30), .yellow)
        XCTAssertEqual(sut(59), .yellow)
        XCTAssertEqual(sut(60), .green)
        XCTAssertEqual(sut(100), .green)
        XCTAssertEqual(sut(101), .green)
    }
    
    func test_percentage() {
        let sut = Double.percentage
        
        XCTAssertEqual(sut(-1)(1), "-1%")
        XCTAssertEqual(sut(0)(1), "0%")
        XCTAssertEqual(sut(29)(1), "29%")
        XCTAssertEqual(sut(30)(1), "30%")
        XCTAssertEqual(sut(59)(1), "59%")
        XCTAssertEqual(sut(60)(1), "60%")
        XCTAssertEqual(sut(100)(1), "100%")
        XCTAssertEqual(sut(101)(1), "101%")

    }
    
    func test_success_rate_0() {
        let zero = SpaceX.Rocket.ViewModel.SuccessRate(percentage: 0, multiplier: 1)
        
        XCTAssertEqual(zero.formatted, "0%")
        XCTAssertEqual(zero.status, .red)
    }
    
    func test_success_rate_50() {
        let fifty = SpaceX.Rocket.ViewModel.SuccessRate(percentage: 50, multiplier: 1)
        
        XCTAssertEqual(fifty.formatted, "50%")
        XCTAssertEqual(fifty.status, .yellow)
    }
    
    func test_success_rate_100() {
        let hundred = SpaceX.Rocket.ViewModel.SuccessRate(percentage: 100, multiplier: 1)
        
        XCTAssertEqual(hundred.formatted, "100%")
        XCTAssertEqual(hundred.status, .green)
    }
    
}
