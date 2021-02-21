//
//  Rocket+ViewModel+Currency.swift
//  BlastOff (iOS)
//
//  Created by Matt Jung on 20/02/2021.
//

import Foundation

extension SpaceX.Rocket.ViewModel {

    struct Currency: Equatable {
        let value: Double
        let formatted: String
        
        init(value: Double, locale: Locale) throws {
            self.value = value
            self.formatted = try Self.formatted(value: value, locale: locale)
                .ifNilthrow("Not valid: \(value) as currency")
        }
    }
}

extension SpaceX.Rocket.ViewModel.Currency {

    static func formatted(value: Double, locale: Locale) -> String? {
        let formatter = with(NumberFormatter(.currency)) {
            $0.locale = locale
            $0.maximumFractionDigits = 0
        }
        return formatter
            .string(from: NSNumber(value: value))
    }
}
