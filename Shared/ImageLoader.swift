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
    
    static let queue = OperationQueue()

    @Published var state: RequestState = .readyToLoad

    enum RequestState {
        case readyToLoad
        case loading
        case success(UIImage)
        case failure
    }
    
    private var subscription: AnyCancellable?
    
    func load(url: URL) {
        let request = URLRequest(url: url, cachePolicy: .useProtocolCachePolicy)
        subscription = AF.request(request)
            .cacheResponse(using: ResponseCacher(behavior: .cache))
            .publishData()
            .tryMap { try $0.data.ifNilthrow("Data Missing")  }
            .tryMap { try UIImage(data: $0).ifNilthrow("Image Missing") }
            .map { RequestState.success($0) }
            .catch(logger: defaultLog, default: RequestState.failure)
            .subscribe(on: Self.queue)
            .receive(on: OperationQueue.main)
            .assign(to: \.state, on: self)
    }
}

