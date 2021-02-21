//
//  SpaceX.swift
//  BlastOff
//
//  Created by Matt Jung on 18/02/2021.
//

import Foundation
import Combine
import Alamofire

enum SpaceX {
    enum api {
        static let url = URL(string: "https://api.spacexdata.com")!
        static let dateFormatter: DateFormatter = .init("yyyy-MM-dd")
        static let jsonDecoder: JSONDecoder = with(.init()) {
            $0.dateDecodingStrategy = .formatted(dateFormatter)
        }
        
        enum v4 {
            static let url = api.url.appendingPathComponent("v4")

            enum rockets {
                static let url = api.v4.url.appendingPathComponent("rockets")
            }
        }
    }
}

extension SpaceX.api.v4.rockets {

    static func publisher() -> AnyPublisher<[SpaceX.Rocket], Error> {
        
        return AF.request(SpaceX.api.v4.rockets.url)
            .publishData()
            .tryMap { try $0.data.ifNilthrow("Data Missing")  }
            .decode(type: [SpaceX.Rocket?].self, decoder: SpaceX.api.jsonDecoder)
            .map { $0.compactMap { $0 } }
            .eraseToAnyPublisher()
    }
}

