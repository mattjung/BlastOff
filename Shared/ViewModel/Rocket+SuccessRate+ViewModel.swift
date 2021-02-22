//
//  Rocket+SuccessRate+ViewModel.swift
//  BlastOff
//
//  Created by Matt Jung on 18/02/2021.
//

import Combine
import Foundation
import SwiftUI

extension SpaceX.Rocket.SuccessRate {
    
    @dynamicMemberLookup
    struct ViewModel: Equatable, Hashable {

        let successRate: SpaceX.Rocket.SuccessRate
        
        init(successRate: SpaceX.Rocket.SuccessRate) {
            self.successRate = successRate
        }
        
        subscript<Value>(dynamicMember keyPath: KeyPath<SpaceX.Rocket.SuccessRate, Value>) -> Value {
            successRate[keyPath: keyPath]
        }
    }
}

extension SpaceX.Rocket.SuccessRate.ViewModel {
    
    var label: String {
        "Success Rate: \(self.formatted)"
    }
}

extension SpaceX.Rocket.SuccessRate {
    
    var viewModel: ViewModel {
        .init(successRate: self)
    }
}
