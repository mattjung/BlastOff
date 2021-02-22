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
    @Binding var isPresenting: Bool
    
    var body: some View {
        NavigationView {
            VStack {
                ScrollView {
                    carousel
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
                footer
            }
            .navigationBarTitle(rocket.name, displayMode: .inline)
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button(action: {
                        isPresenting = false
                    }) {
                        Image(systemName: "multiply")
                    }
                }
            }
        }
    }
    
    var carousel: some View {
        GeometryReader { geometry in
            ZStack(alignment: Alignment(horizontal: .trailing, vertical: .top)) {
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
        }
        .frame(height: 250)
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
            SuccessRate(successRate: rocket.successRate.viewModel)
            Text(rocket.countrylabel)
            Text(rocket.firstFlightDateLabel)
            Text(rocket.costPerLaunchLabel)
            Text(rocket.activeLabel)
        }
    }
}

struct RocketDetail_Previews: PreviewProvider {
    static var previews: some View {
        RocketDetail(rocket: .init(rocket: .preview), isPresenting: .constant(true))
    }
}

extension URL: Identifiable {
    public var id: URL { self }
}
