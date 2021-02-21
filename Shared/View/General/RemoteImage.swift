//
//  RemoteImage.swift
//  BlastOff
//
//  Created by Matt Jung on 19/02/2021.
//

import Combine
import SwiftUI
import Alamofire

struct RemoteImage: View {
    
    @ObservedObject private var imageLoader =
        ImageLoader()
    
    init(url: URL) {
        imageLoader.load(url: url)
    }
    
    @ViewBuilder
    var body: some View {
        image
    }
    
    @ViewBuilder
    var image: some View {
        switch imageLoader.state {
        case .readyToLoad, .loading:
            ProgressView()
        case .success(let image):
            image
                .resizable()
                .aspectRatio(contentMode: .fill)
        case .failure:
            Image(systemName: "icloud.slash")
        }
    }
}
