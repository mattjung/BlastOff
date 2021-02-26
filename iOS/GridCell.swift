//
//  GridCell.swift
//  BlastOff (iOS)
//
//  Created by Matt Jung on 22/02/2021.
//

import UIKit
import Combine

class GridCell: UICollectionViewCell {
    
    var loader = ImageLoader()
    var imageSubscription: AnyCancellable?
    var imageState: ImageLoader.RequestState {
        set {
            imageSubscription?.cancel()
            switch newValue {
            case .success(let image):
                imageView.image = image
            default: break
            }
        }
        get {
            loader.state
        }
    }
    var rocket: SpaceX.Rocket.ViewModel? {
        willSet {
            imageSubscription?.cancel()
            imageSubscription = loader.$state
                .assign(to: \.imageState, on: self)
        }
        didSet {
            guard let rocket = rocket, rocket != oldValue else { return }
            
            if let imageURL = rocket.imageURLs.first {
                loader.load(url: imageURL)
            }
            nameLabel.text = rocket.name
            firstFlightDataLabel.text = rocket.firstFlightDateLabel
            successRateLabel.text = rocket.successRate.viewModel.label
            successRateView.backgroundColor = rocket.successRate.viewModel.status.uiColor
        }
    }
    
    @IBOutlet weak var imageViewShadow: UIView!
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var firstFlightDataLabel: UILabel!
    @IBOutlet weak var successRateLabel: UILabel!
    @IBOutlet weak var successRateView: UIView!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        didInit()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        didInit()
    }
    
    func didInit() {
        contentView.addSubview(nibView(named: "GridCell"), pinning: .all)
        imageViewShadow.layer.shadowColor = UIColor.black.cgColor
        imageViewShadow.layer.shadowOpacity = 0.2
        imageViewShadow.layer.masksToBounds = false
        imageViewShadow.layer.shadowRadius = 5
        imageView.layer.cornerRadius = 5
        imageView.layer.masksToBounds = true

        successRateView.layer.cornerRadius = 5
    }
}
