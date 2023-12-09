//
//  CalculateVisibleIndex.swift
//
//
//  Created by Yudai Asano on 2023/12/09.
//

import UIKit

func calculateVisibleIndex(in collectionView: UICollectionView) -> Int? {
    let visibleRect = CGRect(origin: collectionView.contentOffset, size: collectionView.bounds.size)
    let visiblePoint = CGPoint(x: visibleRect.midX, y: visibleRect.midY)
    let visibleIndexPath = collectionView.indexPathForItem(at: visiblePoint)
    return visibleIndexPath?.item
}
