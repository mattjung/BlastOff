//
//  RocketList.swift
//  BlastOff
//
//  Created by Matt Jung on 18/02/2021.
//

import SwiftUI

struct RocketList: View {
    
    @Binding var showDetail: Bool
    @Binding var rockets: [SpaceX.Rocket.ViewModel]
    @Binding var selectedRocket: SpaceX.Rocket.ViewModel?
    
    var body: some View {
        List(rockets) { rocket in
            RocketRow(rocket: rocket)
                .frame(maxWidth: .infinity, alignment: .leading)
                .contentShape(Rectangle())
                .onTapGesture {
                    showDetail.toggle()
                    selectedRocket = rocket
                }
        }
    }
}

struct RocketList_Previews: PreviewProvider {
    static var previews: some View {
        RocketList(
            showDetail: .constant(false),
            rockets: .constant([.init(rocket: .preview)]),
            selectedRocket: .constant(nil)
        )
    }
}
