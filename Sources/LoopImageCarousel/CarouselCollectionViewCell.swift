//
//  CarouselCollectionViewCell.swift
//
//
//  Created by Yudai Asano on 2023/12/09.
//

import UIKit

open class CarouselCollectionViewCell: UICollectionViewCell {
    open var imageView: UIImageView? {
        if let _ = _imageView {
            return _imageView
        }
        let imageView = UIImageView(frame: .zero)
        contentView.addSubview(imageView)
        _imageView = imageView
        return imageView
    }

    private weak var _imageView: UIImageView?

    override open func layoutSubviews() {
        super.layoutSubviews()
        if let imageView = _imageView {
            imageView.frame = contentView.bounds
        }
    }
}
