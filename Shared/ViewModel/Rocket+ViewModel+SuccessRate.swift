//
//  Rocket+SuccessRate.swift
//  BlastOff (iOS)
//
//  Created by Matt Jung on 20/02/2021.
//

import SwiftUI
import Foundation

extension SpaceX.Rocket.ViewModel {

    struct SuccessRate: Equatable {
        let percentage: Double
        let formatted: String
        let status: Status
        
        init(percentage: Double, multiplier: Int) {
            self.percentage = percentage
            self.formatted = percentage.percentage(multiplier: multiplier) ?? "<Unknown>"
            self.status = Self.status(percentage: percentage)
        }
    }
}

extension SpaceX.Rocket.ViewModel.SuccessRate {
    
    enum Status: Equatable {
        case red, yellow, green
    }
    
    static func status(percentage: Double) -> Status {
        switch percentage {
        case let x where x <= 29: return .red
        case let x where x <= 59: return .yellow
        default: return .green
        }
    }
}

extension SpaceX.Rocket.ViewModel.SuccessRate.Status {
    var color: Color {
        switch self {
        case .red: return .red
        case .yellow: return .yellow
        case .green: return .green
        }
    }
}

extension Double {
    func percentage(multiplier: Int) -> String? {
        let formatter = with(NumberFormatter(.percent)) {
            $0.multiplier = multiplier as NSNumber
            $0.locale = Locale(identifier: "en_US")
        }
        return formatter
            .string(from: NSNumber(value: self))
    }
}

