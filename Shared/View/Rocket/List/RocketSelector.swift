//
//  RocketSelector.swift
//  BlastOff (iOS)
//
//  Created by Matt Jung on 21/02/2021.
//

import SwiftUI

struct RocketSelector: View {
    
    @ObservedObject var viewModel = SpaceX.Rocket.List.ViewModel()
    @Environment(\.horizontalSizeClass) var horizontalSizeClass

    @State var showDetail = false
    @State var selectedRocket: SpaceX.Rocket.ViewModel?
    
    var useUIKit: Bool
    
    var body: some View {
        Group {
            if useUIKit {
                RocketCollection(
                    showDetail: $showDetail,
                    rockets: $viewModel.rockets,
                    selectedRocket: $selectedRocket
                )
            } else {
                if horizontalSizeClass == .compact {
                    RocketList(
                        showDetail: $showDetail,
                        rockets: $viewModel.rockets,
                        selectedRocket: $selectedRocket
                    )
                } else {
                    RocketGrid(
                        showDetail: $showDetail,
                        rockets: $viewModel.rockets,
                        selectedRocket: $selectedRocket
                    )
                }
            }
        }
        .sheet(
            isPresented: .init(
                get: { showDetail && !(selectedRocket == nil) },
                set: { showDetail = $0 }
            )
        ) {
            if let rocket = selectedRocket {
                RocketDetail(rocket: rocket, isPresenting: $showDetail)
            }
        }
        .onChange(of: viewModel.rockets) {
            if selectedRocket == nil {
                selectedRocket = $0.first
            }
        }
    }
}

struct RocketSelector_Previews: PreviewProvider {
    static var previews: some View {
        RocketSelector(useUIKit: true)
    }
}
