//
//  HandleLoop.swift
//
//
//  Created by Yudai Asano on 2023/12/09.
//

import UIKit

let numberOfItemsMultiplier = 10

func handleLoop(collectionView: CarouselCollectionView, numberOfItems: Int) {
    let numberOfTotalItems = numberOfItems * numberOfItemsMultiplier
    let visibleRect = CGRect(origin: collectionView.contentOffset, size: collectionView.bounds.size)
    let visiblePoint = CGPoint(x: visibleRect.midX, y: visibleRect.midY)
    let visibleIndexPath = collectionView.indexPathForItem(at: visiblePoint)
    if let visibleIndex = visibleIndexPath?.item {
        if visibleIndex == 0 {
            collectionView.scrollToItem(at: IndexPath(item: numberOfItems, section: 0), at: .centeredVertically, animated: false)
        }
        else if visibleIndex < numberOfItems {
            let multiplier = Int(ceil(Double(numberOfItemsMultiplier / 2)))
            collectionView.scrollToItem(at: IndexPath(item: numberOfItems * multiplier - 1, section: 0), at: .centeredVertically, animated: false)
        }
        else if visibleIndex > (numberOfTotalItems - numberOfItems) {
            collectionView.scrollToItem(at: IndexPath(item: numberOfItems + 1, section: 0), at: .centeredVertically, animated: false)
        }
    }
}
