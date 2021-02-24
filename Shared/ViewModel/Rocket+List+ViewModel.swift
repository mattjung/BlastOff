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
            
            var rocketAPI: RocketsAPI.Type
            
            @Published var showDetail = false
            @Published var selectedRocket: SpaceX.Rocket.ViewModel?
            @Published var presentDetail = false
            private var store = Set<AnyCancellable>()
            
            init(rocketAPI: RocketsAPI.Type = SpaceX.api.v4.rockets.self) {
                
                self.rocketAPI = rocketAPI
                
                rocketAPI
                    .get()
                    .map { $0.map(\.viewModel) }
                    .catch(logger: defaultLog, default: rockets)
                    .assign(to: \.rockets, on: self)
                    .store(in: &store)
                
                $showDetail
                    .combineLatest($selectedRocket)
                    .map { $0 && !($1 == nil) }
                    .assign(to: \.presentDetail, on: self)
                    .store(in: &store)
            }
        }
    }
}
