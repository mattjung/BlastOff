//
//  RocketCarouselList.swift
//  BlastOff (iOS)
//
//  Created by Matt Jung on 21/02/2021.
//

import SwiftUI

struct RocketGrid: View {
    
    @Binding var showDetail: Bool
    @Binding var rockets: [SpaceX.Rocket.ViewModel]
    @Binding var selectedRocket: SpaceX.Rocket.ViewModel?
    
    var body: some View {
        ScrollView {
            LazyVGrid(columns: [GridItem(.adaptive(minimum: 200), spacing: 20)], alignment: .center, spacing: 20) {
                ForEach(rockets) { rocket in
                    VStack(alignment: .leading, spacing: 10) {
                        RocketHeroImage(rocket: rocket)
                            .frame(height: 150)
                            .frame(minWidth: 200)
                            .background(Rectangle().fill(Color.gray))
                            .cornerRadius(5)
                            .shadow(color: Color.black.opacity(0.2),radius: 5)
                        RocketInfoPreview(rocket: rocket)

                    }
                    .onTapGesture {
                        showDetail.toggle()
                        selectedRocket = rocket
                    }
                }
            }.padding()
        }
    }
}

struct RocketCarouselList_Previews: PreviewProvider {
    static var previews: some View {
        RocketGrid(
            showDetail: .constant(false),
            rockets: .constant([.init(rocket: .preview)]),
            selectedRocket: .constant(nil)
        )     .previewLayout(PreviewLayout.sizeThatFits)
    }
}
