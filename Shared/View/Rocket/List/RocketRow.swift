//
//  RocketRow.swift
//  BlastOff
//
//  Created by Matt Jung on 19/02/2021.
//

import SwiftUI

struct RocketRow: View {
    
    let rocket: SpaceX.Rocket.ViewModel
    @Environment(\.horizontalSizeClass) var horizontalSizeClass

    var body: some View {
        HStack(alignment: .center, spacing: 10) {
            RocketHeroImage(rocket: rocket)
                .frame(width: 100)
                .frame(maxHeight: .infinity)
                .background(Rectangle().fill(Color.gray))
                .cornerRadius(3)
            RocketInfoPreview(rocket: rocket)
        }
    }
}

struct RocketRow_Previews: PreviewProvider {
    static var previews: some View {
        RocketRow(rocket: .init(rocket: .preview))
            .previewLayout(PreviewLayout.sizeThatFits)
    }
}
