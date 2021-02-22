//
//  BlastOffApp.swift
//  Shared
//
//  Created by Matt Jung on 18/02/2021.
//

import SwiftUI

@main
struct BlastOffApp: App {
    
    var body: some Scene {
        WindowGroup {
            NavigationView {
                RocketSelector(useUIKit: true)
                    .navigationTitle("Rockets")
            }
            .navigationViewStyle(StackNavigationViewStyle())
        }
    }
}
