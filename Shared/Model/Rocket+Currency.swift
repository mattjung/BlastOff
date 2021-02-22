//
//  Rocket+ViewModel+Currency.swift
//  BlastOff (iOS)
//
//  Created by Matt Jung on 20/02/2021.
//

import Foundation

extension SpaceX.Rocket {

    struct Currency: Codable, Equatable, Hashable {
        let value: Double
        let formatted: String
        
        init(value: Double, locale: Locale) throws {
            self.value = value
            self.formatted = try Self.formatted(value: value, locale: locale)
                .ifNilthrow("Not valid: \(value) as currency")
        }
        
        init(from decoder: Decoder) throws {
            let container = try decoder.singleValueContainer()
            let value = try container.decode(Double.self)
            try self.init(value: value, locale: Locale(identifier: "en_US"))
        }
        
        func encode(to encoder: Encoder) throws {
            var container = encoder.singleValueContainer()
            try container.encode(value)
        }
    }
}

extension SpaceX.Rocket.Currency {

    static func formatted(value: Double, locale: Locale) -> String? {
        let formatter = with(NumberFormatter(.currency)) {
            $0.locale = locale
            $0.maximumFractionDigits = 0
        }
        return formatter
            .string(from: NSNumber(value: value))
    }
}
