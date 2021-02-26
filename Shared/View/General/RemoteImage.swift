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
    
    @StateObject private var imageLoader: ImageLoader
    
    let url: URL
    
    init(url: URL) {
        self.url = url
        _imageLoader = StateObject(wrappedValue: ImageLoader())
    }
    
    var body: some View {
        image.onAppear { imageLoader.load(url: url) }
    }
    
    @ViewBuilder
    var image: some View {
        switch imageLoader.state {
        case .readyToLoad, .loading:
            ProgressView()
        case .success(let image):
            image.image
                .resizable()
                .aspectRatio(contentMode: .fill)
        case .failure:
            Image(systemName: "icloud.slash")
        }
    }
}
