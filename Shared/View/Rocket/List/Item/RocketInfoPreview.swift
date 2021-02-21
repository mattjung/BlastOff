//
//  RocketInfoPreview.swift
//  BlastOff (iOS)
//
//  Created by Matt Jung on 21/02/2021.
//

import SwiftUI

struct RocketInfoPreview: View {
    
    let rocket: SpaceX.Rocket.ViewModel
    
    var body: some View {
        VStack(alignment: .leading, spacing: 5) {
            Text(rocket.name)
                .fontWeight(.medium)
            Text("First flight: \(rocket.firstFlightDate)")
            SuccessRateView(successRate: rocket.successRate)
        }
    }
}

struct RocketInfoPreview_Previews: PreviewProvider {
    static var previews: some View {
        RocketInfoPreview(rocket: .init(rocket: .preview))            .previewLayout(PreviewLayout.sizeThatFits)
    }
}
