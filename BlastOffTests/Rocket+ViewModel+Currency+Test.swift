//
//  Rocket+ViewModel+Currency+Test.swift
//  Tests iOS
//
//  Created by Matt Jung on 20/02/2021.
//

import XCTest
@testable import BlastOff

class Rocket_ViewModel_Currency_Test: XCTestCase {
    
    func test_currency_formatted() {
        let sut = SpaceX.Rocket.ViewModel.Currency.formatted
        let en_EN = Locale(identifier: "en_US")
            
        XCTAssertEqual(sut(-1, en_EN), "-$1")
        XCTAssertEqual(sut(0, en_EN), "$0")
        XCTAssertEqual(sut(1, en_EN), "$1")
        XCTAssertEqual(sut(100, en_EN), "$100")
        XCTAssertEqual(sut(1000, en_EN), "$1,000")
    }
    
    func test_currency_0() {
        let en_EN = Locale(identifier: "en_US")
        let zero = try? SpaceX.Rocket.ViewModel.Currency(value: 0, locale: en_EN)
        
        XCTAssertEqual(zero?.formatted, "$0")
    }
    
    func test_currency_million() {
        let en_EN = Locale(identifier: "en_US")
        let million = try? SpaceX.Rocket.ViewModel.Currency(value: 1000000, locale: en_EN)
        
        XCTAssertEqual(million?.formatted, "$1,000,000")
    }
}
