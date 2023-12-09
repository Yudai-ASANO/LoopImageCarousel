//
//  Configuration.swift
//
//
//  Created by Yudai Asano on 2023/12/09.
//

import Foundation

public struct Configuration {
    public var perView: CGFloat
    public var interItemSpacing: CGFloat
    public var timeInterval: CGFloat

    public init(perView: CGFloat = 1.0, interItemSpacing: CGFloat = .zero, timeInterval: CGFloat = .zero) {
        self.perView = perView
        self.interItemSpacing = interItemSpacing
        self.timeInterval = timeInterval
    }
}
