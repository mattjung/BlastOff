//
//  RocketSelector.swift
//  BlastOff (iOS)
//
//  Created by Matt Jung on 21/02/2021.
//

import SwiftUI
import Combine

struct RocketSelector: View {
    
    @Environment(\.horizontalSizeClass) var horizontalSizeClass
    
    @ObservedObject var viewModel: SpaceX.Rocket.List.ViewModel
    var useUIKit: Bool
        
    var body: some View {
        Group {
            if useUIKit {
                RocketCollection(
                    showDetail: $viewModel.showDetail,
                    rockets: $viewModel.rockets,
                    selectedRocket: $viewModel.selectedRocket
                )
            } else {
                if horizontalSizeClass == .compact {
                    RocketList(
                        showDetail: $viewModel.showDetail,
                        rockets: $viewModel.rockets,
                        selectedRocket: $viewModel.selectedRocket
                    )
                } else {
                    RocketGrid(
                        showDetail: $viewModel.showDetail,
                        rockets: $viewModel.rockets,
                        selectedRocket: $viewModel.selectedRocket
                    )
                }
            }
        }
        .sheet(
            isPresented: $viewModel.showDetail
        ) {
            if let rocket = viewModel.selectedRocket {
                RocketDetail(rocket: rocket, isPresenting: $viewModel.showDetail)
            }
        }
    }
}

struct RocketSelector_Previews: PreviewProvider {
    static var previews: some View {
        RocketSelector(viewModel: .init(), useUIKit: true)
    }
}
