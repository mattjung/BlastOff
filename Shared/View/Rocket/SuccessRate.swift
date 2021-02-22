//
//  SuccessRate.swift
//  BlastOff (iOS)
//
//  Created by Matt Jung on 20/02/2021.
//

import SwiftUI

struct SuccessRate: View {
    
    let successRate: SpaceX.Rocket.SuccessRate.ViewModel
    
    var body: some View {
        Text(successRate.label)
            .padding(.horizontal, 10)
            .padding(.vertical, 5)
            .background(
                RoundedRectangle(cornerRadius: 5)
                    .fill(successRate.status.color)
            )
    }
}

struct SuccessRateView_Previews: PreviewProvider {
    static var previews: some View {
        SuccessRate(successRate: SpaceX.Rocket.ViewModel(rocket: .preview).successRate.viewModel)
            .previewLayout(PreviewLayout.sizeThatFits)

    }
}
