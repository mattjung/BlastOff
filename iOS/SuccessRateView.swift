//
//  SuccessRateView.swift
//  BlastOff (iOS)
//
//  Created by Matt Jung on 22/02/2021.
//

import UIKit
import SwiftUI

class SuccessRateView: UIView {
    
    var host: UIHostingController<SuccessRate>? {
        willSet {
            host?.view.removeFromSuperview()
        }
        didSet {
            
        }
    }
    
    var rocket: SpaceX.Rocket.ViewModel? {
        didSet {
            guard let rocket = rocket else { return }
            host = UIHostingController(rootView: SuccessRate(successRate: rocket.successRate.viewModel))
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
}
