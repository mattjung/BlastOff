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
    struct ViewModel: Identifiable, Equatable {
        
        let id: String
        let name: String
        let imageURLs: [URL]
        let successRate: SuccessRate
        let firstFlightDate: String
        let description: String
        let active: Bool
        let country: String
        let costPerLaunch: Currency?
        let wikipediaURL: URL
        
        init(rocket: SpaceX.Rocket) {
            self.id = rocket.id
            self.name = rocket.name
            self.imageURLs = rocket.flickr_images
            self.successRate = SuccessRate(percentage: rocket.success_rate_pct, multiplier: 1)
            self.firstFlightDate = DateFormatter(.medium)
                .string(from: rocket.first_flight)
            self.description = rocket.description
            self.active = rocket.active
            self.country = rocket.country
            self.wikipediaURL = rocket.wikipedia            
            self.costPerLaunch = try? .init(value: rocket.cost_per_launch, locale: Locale(identifier: "en_US"))
        }
    }
}
