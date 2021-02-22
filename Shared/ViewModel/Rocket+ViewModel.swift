//
//  Rocket+ViewModel.swift
//  BlastOff
//
//  Created by Matt Jung on 18/02/2021.
//

import Combine
import Foundation
import SwiftUI

extension SpaceX.Rocket {
    
    @dynamicMemberLookup
    struct ViewModel: Identifiable, Equatable, Hashable {

        var id: String { rocket.id }
        let rocket: SpaceX.Rocket
        
        init(rocket: SpaceX.Rocket) {
            self.rocket = rocket
        }
        
        subscript<Value>(dynamicMember keyPath: KeyPath<SpaceX.Rocket, Value>) -> Value {
            rocket[keyPath: keyPath]
        }
    }
}

extension SpaceX.Rocket.ViewModel {
    
    var firstFlightDateLabel: String {
        let firstFlightDateString = DateFormatter(.medium)
            .string(from: rocket.firstFlightDate)
        return "First flight date: \(firstFlightDateString)"
    }
    
    var activeLabel: String {
        rocket.active ? "Active" : "Not Active"
    }
    
    var countrylabel: String {
        "Country: \(rocket.country)"
    }
    
    var costPerLaunchLabel: String {
        "Cost per launch: \(rocket.costPerLaunch.formatted)"
    }
    
    var successRateLabel: String {
        "Success Rate: \(rocket.successRate.formatted)"
    }
}
