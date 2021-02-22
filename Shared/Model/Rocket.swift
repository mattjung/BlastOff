//
//  Rocket.swift
//  BlastOff
//
//  Created by Matt Jung on 18/02/2021.
//

import Foundation

extension SpaceX {
    struct Rocket: Codable, Equatable, Hashable {
        let id: String
        let name: String
        let imageURLs: [URL]
        let successRate: SuccessRate
        let active: Bool
        let country: String
        let description: String
        let firstFlightDate: Date
        let costPerLaunch: Currency
        let wikipediaURL: URL
        
        enum CodingKeys: String, CodingKey {
            case id
            case name
            case imageURLs = "flickr_images"
            case successRate = "success_rate_pct"
            case active
            case country
            case description
            case firstFlightDate = "first_flight"
            case costPerLaunch = "cost_per_launch"
            case wikipediaURL = "wikipedia"
        }
    }
}

extension SpaceX.Rocket {
    func with(
        id: String? = nil,
        name: String? = nil,
        imageURLs: [URL]? = nil,
        successRate: SuccessRate? = nil,
        active: Bool? = nil,
        country: String? = nil,
        description: String? = nil,
        firstFlightDate: Date? = nil,
        costPerLaunch: Currency? = nil,
        wikipediaURL: URL? = nil) -> SpaceX.Rocket
    {
        .init(
            id: id ?? self.id,
            name: name ?? self.name,
            imageURLs: imageURLs ?? self.imageURLs,
            successRate: successRate ?? self.successRate,
            active: active ?? self.active,
            country: country ?? self.country,
            description: description ?? self.description,
            firstFlightDate: firstFlightDate ?? self.firstFlightDate,
            costPerLaunch: costPerLaunch ?? self.costPerLaunch,
            wikipediaURL: wikipediaURL ?? self.wikipediaURL
        )
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
        imageURLs: [
            "https://farm5.staticflickr.com/4599/38583829295_581f34dd84_b.jpg".url!,
            "https://farm5.staticflickr.com/4645/38583830575_3f0f7215e6_b.jpg".url!,
            "https://farm5.staticflickr.com/4696/40126460511_b15bf84c85_b.jpg".url!,
            "https://farm5.staticflickr.com/4711/40126461411_aabc643fd8_b.jpg".url!
        ],
        successRate: SpaceX.Rocket.SuccessRate(percentage: 100, multiplier: 1),
        active: true,
        country: "United States",
        description: "With the ability to lift into orbit over 54 metric tons (119,000 lb)--a mass equivalent to a 737 jetliner loaded with passengers, crew, luggage and fuel--Falcon Heavy can lift more than twice the payload of the next closest operational vehicle, the Delta IV Heavy, at one-third the cost.",
        firstFlightDate: Date("2018-02-06", as: SpaceX.api.dateFormatter)!,
        costPerLaunch: try! SpaceX.Rocket.Currency(value: 90000000, locale: Locale(identifier: "en_US")),
        wikipediaURL: "https://en.wikipedia.org/wiki/Falcon_Heavy".url!
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
