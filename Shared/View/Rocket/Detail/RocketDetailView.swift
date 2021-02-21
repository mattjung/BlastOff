//
//  RocketDetail.swift
//  BlastOff
//
//  Created by Matt Jung on 20/02/2021.
//

import SwiftUI

struct RocketDetail: View {
    
    @Environment(\.horizontalSizeClass) var horizontalSizeClass
    let rocket: SpaceX.Rocket.ViewModel

    var body: some View {
        ScrollView {
            VStack {
                GeometryReader { geometry in
                    TabView {
                        ForEach(rocket.imageURLs) { url in
                            RemoteImage(url: url)
                                .aspectRatio(contentMode: .fit)
                                .frame(height: 250)
                        }
                    }
                    .background(Rectangle()
                                    .fill(Color.black))
                    .tabViewStyle(PageTabViewStyle())
                    .frame(width: geometry.size.width, height: 250)

                }
                .frame(height: 250)
                
                if horizontalSizeClass == .compact {
                    VStack(alignment: .leading, spacing: 10) {
                        mainInfo
                        infoCard
                    }.padding()
                } else {
                    HStack(alignment: .top, spacing: 20) {
                        VStack(alignment: .trailing, spacing: 5) {
                            infoCard
                        }
                        mainInfo
                    }.padding()
                }
            }
        }
        footer
    }
    
    var footer: some View {
        Link(destination: rocket.wikipediaURL) {
            HStack {
                Image(systemName: "link")
                Text("Wikipedia").bold()
            }
            .foregroundColor(.white)
            .frame(maxWidth: .infinity)
            .padding()
            
        }
        .background(
            RoundedRectangle(cornerRadius: 5)
                .fill(Color.blue)
        )
        .padding()
    }
    
    var mainInfo: some View {
        VStack(alignment: .leading, spacing: 10) {
            Text(rocket.name)
                .font(.title)
            Text(rocket.description)
        }
    }
    var infoCard: some View {
        Group {
            SuccessRateView(successRate: rocket.successRate)
            Text("Country: \(rocket.country)")
            Text("First flight: \(rocket.firstFlightDate)")
            Text("Cost per launch: \(rocket.costPerLaunch?.formatted ?? "<Unknown>")")
            Text(rocket.active ? "Active" : "Not active")
        }
    }
}

struct RocketDetail_Previews: PreviewProvider {
    static var previews: some View {
        RocketDetail(rocket: .init(rocket: .preview))
    }
}

extension URL: Identifiable {
    public var id: URL { self }
}
