//
//  CarouselCollectionView.swift
//
//
//  Created by Yudai Asano on 2023/12/09.
//

import UIKit

class CarouselCollectionView: UICollectionView {
    override var scrollsToTop: Bool {
        set {
            super.scrollsToTop = false
        }
        get {
            false
        }
    }

    override var contentInset: UIEdgeInsets {
        set {
            super.contentInset = .zero
            if newValue.top > 0 {
                let contentOffset = CGPoint(x: contentOffset.x, y: contentOffset.y + newValue.top)
                self.contentOffset = contentOffset
            }
        }
        get {
            super.contentInset
        }
    }

    override init(frame: CGRect, collectionViewLayout layout: UICollectionViewLayout) {
        super.init(frame: frame, collectionViewLayout: layout)
        commonInit()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        commonInit()
    }

    private func commonInit() {
        showsHorizontalScrollIndicator = false
        showsVerticalScrollIndicator = false
        alwaysBounceVertical = false
        scrollsToTop = false
        contentInsetAdjustmentBehavior = .never
    }
}
