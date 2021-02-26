//
//  RocketCollection.swift
//  BlastOff
//
//  Created by Matt Jung on 22/02/2021.
//

import UIKit
import SwiftUI


struct RocketCollection: UIViewRepresentable {
    
    @Binding var showDetail: Bool
    @Binding var rockets: [SpaceX.Rocket.ViewModel]
    @Binding var selectedRocket: SpaceX.Rocket.ViewModel?

    func makeCoordinator() -> Coordinator {
        Coordinator(parent: self)
    }
    
    func updateUIView(_ uiView: RocketsCollectionView, context: Context) {
        uiView.rockets = rockets
    }
    
    func makeUIView(context: Context) -> RocketsCollectionView {
        let view = RocketsCollectionView()
        view.contentInsetAdjustmentBehavior = .never
        view.backgroundColor = UIColor.systemBackground
        context.coordinator.collectionView = view
        view.delegate = context.coordinator
        return view
    }

    class Coordinator: NSObject, UICollectionViewDelegate {

        var parent: RocketCollection
        weak var collectionView: RocketsCollectionView?

        init(parent: RocketCollection) {
            self.parent = parent
        }
        
        func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
            parent.showDetail = true
            parent.selectedRocket = self.collectionView?.diffableDataSource.itemIdentifier(for: indexPath)
        }
    }
}

class RocketsCollectionView: UICollectionView {

    var rockets: [SpaceX.Rocket.ViewModel] {
        didSet {
            guard rockets != oldValue else { return }
            refresh(animated: true) }
    }
    
    enum Section {
        case rockets
    }
    
    typealias DataSource = UICollectionViewDiffableDataSource<Section, SpaceX.Rocket.ViewModel>
    typealias Snapshot = NSDiffableDataSourceSnapshot<Section, SpaceX.Rocket.ViewModel>

    lazy var diffableDataSource = DataSource(
        collectionView: self,
        cellProvider: { (collectionView, indexPath, rocket) ->
            UICollectionViewCell? in
            let cell = collectionView.dequeueReusableCell(
                withReuseIdentifier: "GridCell",
                for: indexPath) as? GridCell
            cell?.rocket = rocket
            return cell
        })
    
    init(rockets: [SpaceX.Rocket.ViewModel] = []) {
        self.rockets = rockets
        
        let layout = UICollectionViewCompositionalLayout { (sectionIndex: Int, layoutEnv: NSCollectionLayoutEnvironment) -> NSCollectionLayoutSection? in
            
            let itemSize: NSCollectionLayoutSize
            let groupSize: NSCollectionLayoutSize
            
            switch layoutEnv.traitCollection.horizontalSizeClass {
            case .compact:
                itemSize = NSCollectionLayoutSize(
                    widthDimension: .fractionalWidth(1),
                    heightDimension: .estimated(300))
                
                groupSize = itemSize
                
            case .regular:
                itemSize = NSCollectionLayoutSize(
                    widthDimension: .fractionalWidth(0.25),
                    heightDimension: .estimated(300))
                
                groupSize = NSCollectionLayoutSize(
                    widthDimension: .fractionalWidth(1),
                    heightDimension: .estimated(300))
                
            default:
                return nil
            }
            
            let item = NSCollectionLayoutItem(layoutSize: itemSize)
            
            let count = layoutEnv.traitCollection.horizontalSizeClass == .compact
                ? 1
                : 3
            
            let group = with(NSCollectionLayoutGroup.horizontal(
                layoutSize: groupSize,
                subitem: item,
                count: count))
            {
                $0.interItemSpacing = .fixed(20)
            }
                             
            let section = with(NSCollectionLayoutSection(group: group)) {
                $0.interGroupSpacing = 20
                $0.contentInsets = NSDirectionalEdgeInsets(
                    top: 16,
                    leading: 16,
                    bottom: 0,
                    trailing: 16)
            }
            
            return section
        }
        
        super.init(frame: .zero, collectionViewLayout: layout)
        dataSource = diffableDataSource
        register(GridCell.self, forCellWithReuseIdentifier: "GridCell")
        refresh(animated: false)
    }
    
    func refresh(animated: Bool) {
        var snapshot = Snapshot()
        snapshot.appendSections([.rockets])
        snapshot.appendItems(rockets)
        diffableDataSource.apply(snapshot, animatingDifferences: animated)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
