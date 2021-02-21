//
//  Rocket+List+ViewModel.swift
//  BlastOff (iOS)
//
//  Created by Matt Jung on 20/02/2021.
//

import OSLog
import Combine

let defaultLog = Logger()

extension SpaceX.Rocket {
    enum List {
        class ViewModel: ObservableObject {
            
            @Published var rockets: [SpaceX.Rocket.ViewModel] = []
            
            var subscription: AnyCancellable?
            
            init() {
                subscription = SpaceX.api.v4.rockets
                    .publisher()
                    .map { $0.map(\.viewModel) }
                    .catch(logger: defaultLog, default: rockets)
                    .assign(to: \.rockets, on: self)
            }
        }
    }
}
