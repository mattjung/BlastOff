//
//  RocketHeroImage.swift
//  BlastOff (iOS)
//
//  Created by Matt Jung on 21/02/2021.
//

import SwiftUI

struct RocketHeroImage: View {
    
    let rocket: SpaceX.Rocket.ViewModel
    
    var body: some View {
        Group {
            if let url = rocket.imageURLs.first {
                RemoteImage(url: url)
            } else {
                Image(systemName: "icloud.slash")
            }
        }
    }
}

struct RocketHeroImage_Previews: PreviewProvider {
    static var previews: some View {
        RocketHeroImage(rocket: .init(rocket: .preview))
    }
}
