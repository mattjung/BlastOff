//
//  SuccessRateView.swift
//  BlastOff (iOS)
//
//  Created by Matt Jung on 20/02/2021.
//

import SwiftUI

struct SuccessRateView: View {
    
    let successRate: SpaceX.Rocket.ViewModel.SuccessRate
    
    var body: some View {
        Text("Success Rate: \(successRate.formatted)")
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
        SuccessRateView(successRate: SpaceX.Rocket.ViewModel(rocket: .preview).successRate)
            .previewLayout(PreviewLayout.sizeThatFits)

    }
}
