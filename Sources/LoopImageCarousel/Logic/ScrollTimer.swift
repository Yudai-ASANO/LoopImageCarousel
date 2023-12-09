//
//  ScrollTimer.swift
//
//
//  Created by Yudai Asano on 2023/12/09.
//

import Combine
import Foundation

class ScrollTimer {
    private var cancellable: AnyCancellable?

    func start(interval: Double, execute: @escaping () -> Void) {
        cancellable?.cancel() // 前のタイマーをキャンセル
        cancellable = Timer.publish(every: interval, on: .main, in: .common)
            .autoconnect()
            .sink(receiveValue: { _ in
                execute()
            })
    }

    func stop() {
        cancellable?.cancel()
    }
}
