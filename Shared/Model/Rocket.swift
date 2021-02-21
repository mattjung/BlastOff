//
//  Rocket.swift
//  BlastOff
//
//  Created by Matt Jung on 18/02/2021.
//

import Foundation

extension SpaceX {
    struct Rocket: Codable {
        let id: String
        let name: String
        let flickr_images: [URL]
        let success_rate_pct: Double
        let active: Bool
        let country: String
        let description: String
        let first_flight: Date
        let cost_per_launch: Double
        let wikipedia: URL
    }
}

extension SpaceX.Rocket {
    
    var viewModel: SpaceX.Rocket.ViewModel {
        .init(rocket: self)
    }
}

extension SpaceX.Rocket {
    static let preview: SpaceX.Rocket = .init(
        id: "5e9d0d95eda69974db09d1ed",
        name: "Falcon Heavy",
        flickr_images: [
            "https://farm5.staticflickr.com/4599/38583829295_581f34dd84_b.jpg".url!,
            "https://farm5.staticflickr.com/4645/38583830575_3f0f7215e6_b.jpg".url!,
            "https://farm5.staticflickr.com/4696/40126460511_b15bf84c85_b.jpg".url!,
            "https://farm5.staticflickr.com/4711/40126461411_aabc643fd8_b.jpg".url!
          ],
        success_rate_pct: 100,
        active: true,
        country: "United States",
        description: "With the ability to lift into orbit over 54 metric tons (119,000 lb)--a mass equivalent to a 737 jetliner loaded with passengers, crew, luggage and fuel--Falcon Heavy can lift more than twice the payload of the next closest operational vehicle, the Delta IV Heavy, at one-third the cost.",
        first_flight: Date("2018-02-06", as: SpaceX.api.dateFormatter)!,
        cost_per_launch: 90000000,
        wikipedia: "https://en.wikipedia.org/wiki/Falcon_Heavy".url!
    )
}

extension Date {
    init?(_ string: String, as formatter: DateFormatter) {
        guard let date = formatter.date(from: string) else {
            return nil
        }
        
        self = date
    }
}
