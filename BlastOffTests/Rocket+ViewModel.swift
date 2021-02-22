//
//  Rocket+ViewModel+Test.swift
//  Tests iOS
//
//  Created by Matt Jung on 20/02/2021.
//

import XCTest
@testable import BlastOff

class Rocket_ViewModel_Test: XCTestCase {
    
    static let testRocket: SpaceX.Rocket = .init(
        id: "5e9d0d95eda69974db09d1ed",
        name: "Falcon Heavy",
        imageURLs: [
            "https://farm5.staticflickr.com/4599/38583829295_581f34dd84_b.jpg".url!,
        ],
        successRate: .init(percentage: 100, multiplier: 1),
        active: true,
        country: "United States",
        description: "Description",
        firstFlightDate: Date("2018-02-06", as: SpaceX.api.dateFormatter)!,
        costPerLaunch: try! .init(value: 90000000, locale: Locale(identifier: "en_US")),
        wikipediaURL: "https://en.wikipedia.org/wiki/Falcon_Heavy".url!
    )
    
    func test_viewModel() {
        let sut = SpaceX.Rocket.ViewModel(rocket: Self.testRocket)
        
        XCTAssertEqual(sut.activeLabel, "Active")
        XCTAssertEqual(sut.firstFlightDateLabel, "First flight date: Feb 6, 2018")
        XCTAssertEqual(sut.countrylabel, "Country: United States")
        XCTAssertEqual(sut.successRateLabel, "Success Rate: 100%")
        XCTAssertEqual(sut.costPerLaunchLabel, "Cost per launch: $90,000,000")
    }
    
    func test_viewModel_active() {
        let sut = SpaceX.Rocket.ViewModel(rocket: Self.testRocket.with(active: false))
        
        XCTAssertEqual(sut.activeLabel, "Not Active")
    }
}

