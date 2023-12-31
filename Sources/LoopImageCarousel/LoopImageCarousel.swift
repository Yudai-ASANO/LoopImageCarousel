//
//  LoopImageCarousel.swift
//
//
//  Created by Yudai Asano on 2023/12/09.
//

import Combine
import UIKit

public protocol LoopImageCarouselDataSource: AnyObject {
    func numberOfItems(in loopImageCarousel: LoopImageCarousel) -> Int
    func loopImageCarousel(_ loopImageCarousel: LoopImageCarousel, cellForItemAt index: Int) -> CarouselCollectionViewCell
}

public protocol LoopImageCarouselDelegate: AnyObject {
    func loopImageCarousel(_ loopImageCarousel: LoopImageCarousel, didSelectItemAt index: Int)
    func loopImageCarousel(_ loopImageCarousel: LoopImageCarousel, currentItemAt index: Int)
}

open class LoopImageCarousel: UIView, UICollectionViewDataSource, UICollectionViewDelegate {
    open weak var delegate: LoopImageCarouselDelegate?
    open weak var dataSource: LoopImageCarouselDataSource?

    public var configuration: Configuration = .init() {
        didSet {
            collectionView.collectionViewLayout = createCarouselLayout(configuration: configuration)
        }
    }

    override public init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }

    public required init?(coder: NSCoder) {
        super.init(coder: coder)
        commonInit()
    }

    override open func layoutSubviews() {
        super.layoutSubviews()
        contenteView.frame = bounds
        collectionView.frame = contenteView.bounds
    }

    public func register(_ cellClass: AnyClass?, forCellWithReuseIdentifier identifier: String) {
        collectionView.register(cellClass, forCellWithReuseIdentifier: identifier)
    }

    public func dequeueReusableCell(withReuseIdentifier identifier: String, at index: Int) -> CarouselCollectionViewCell {
        let indexPath = IndexPath(item: index, section: .zero)
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: identifier, for: indexPath)
        guard cell.isKind(of: CarouselCollectionViewCell.self) else {
            fatalError("Cell class must be subclass of CarouselCollectionViewCell")
        }
        return cell as! CarouselCollectionViewCell
    }

    public func reloadData() {
        collectionView.reloadData()
    }

    // MARK: UICollectionViewDataSource

    public func numberOfSections(in collectionView: UICollectionView) -> Int {
        1
    }

    public func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        dataSource!.numberOfItems(in: self) * numberOfItemsMultiplier
    }

    public func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let index = indexPath.item % dataSource!.numberOfItems(in: self)
        return dataSource!.loopImageCarousel(self, cellForItemAt: index)
    }

    // MARK: UICollectionViewDelegate

    public func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let index = indexPath.item % dataSource!.numberOfItems(in: self)
        delegate?.loopImageCarousel(self, didSelectItemAt: index)
    }

    private var collectionView: CarouselCollectionView!
    private var contenteView: UIView!

    private let timer: ScrollTimer = .init()

    private func commonInit() {
        let contentView = UIView(frame: .zero)
        addSubview(contentView)
        contenteView = contentView
        let collectionViewLayout = createCarouselLayout(configuration: configuration)
        let collectionView = CarouselCollectionView(frame: .zero, collectionViewLayout: collectionViewLayout)
        collectionView.delegate = self
        collectionView.dataSource = self
        contenteView.addSubview(collectionView)
        self.collectionView = collectionView
    }

    private func createCarouselLayout(configuration: Configuration) -> UICollectionViewLayout {
        let layout = UICollectionViewCompositionalLayout { [weak self] _, _ in
            self?.createSection(configuration: configuration)
        }
        return layout
    }

    private func createItem(interItemSpacing: CGFloat) -> NSCollectionLayoutItem {
        let itemSize = NSCollectionLayoutSize(
            widthDimension: .fractionalWidth(1.0),
            heightDimension: .fractionalHeight(1.0)
        )
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        item.contentInsets = NSDirectionalEdgeInsets(
            top: 0,
            leading: interItemSpacing,
            bottom: 0,
            trailing: interItemSpacing
        )
        return item
    }

    private func createGroup(perView: CGFloat, interItemSpacing: CGFloat) -> NSCollectionLayoutGroup {
        let groupWidth = NSCollectionLayoutDimension.fractionalWidth(1 / perView)
        let itemHeight = NSCollectionLayoutDimension.fractionalHeight(1.0)
        let groupSize = NSCollectionLayoutSize(
            widthDimension: groupWidth,
            heightDimension: itemHeight
        )
        return NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [createItem(interItemSpacing: interItemSpacing)])
    }

    private func createSection(configuration: Configuration) -> NSCollectionLayoutSection {
        let section = NSCollectionLayoutSection(group: createGroup(perView: configuration.perView, interItemSpacing: configuration.interItemSpacing))
        section.orthogonalScrollingBehavior = .groupPagingCentered
        section.visibleItemsInvalidationHandler = handleVisibleItemsInvalidation
        return section
    }

    private func handleVisibleItemsInvalidation(visibleItems: [NSCollectionLayoutVisibleItem], point: CGPoint, environment: NSCollectionLayoutEnvironment) {
        let numberOfRawItems = dataSource!.numberOfItems(in: self)
        handleLoop(collectionView: collectionView, numberOfItems: numberOfRawItems)
        if configuration.timeInterval > 0 {
            timer.start(interval: configuration.timeInterval) { [weak self] in
                guard let self else { return }
                if let visibleIndex = calculateVisibleIndex(in: collectionView) {
                    collectionView.scrollToItem(at: IndexPath(item: visibleIndex + 1, section: 0), at: .centeredHorizontally, animated: true)
                }
            }
        }
        if let visibleIndex = calculateVisibleIndex(in: collectionView) {
            let index = visibleIndex % dataSource!.numberOfItems(in: self)
            delegate?.loopImageCarousel(self, currentItemAt: index)
        }
    }
}
