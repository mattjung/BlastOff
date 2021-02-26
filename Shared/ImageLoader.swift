//
//  ImageLoader.swift
//  BlastOff
//
//  Created by Matt Jung on 20/02/2021.
//

import Alamofire
import UIKit
import Combine

class ImageLoader: ObservableObject {
    
    @Published var state: RequestState = .readyToLoad
    
    enum RequestState {
        case readyToLoad
        case loading
        case success(UIImage)
        case failure
    }
    
    private var subscription: AnyCancellable?
    
    func load(url: URL) {
        subscription = URLSession.shared
            .dataTaskPublisher(for: url)
            .tryMap {
                guard ($0.response as? HTTPURLResponse)?.statusCode == 200 else {
                    throw URLError(.badServerResponse)
                }; return $0.data
            }
            .tryMap { try UIImage(data: $0).ifNilthrow("Image Missing") }
            .map { RequestState.success($0) }
            .catch(logger: defaultLog, default: RequestState.failure)
            .receive(on: DispatchQueue.main)
            .assign(to: \.state, on: self)
    }
}

