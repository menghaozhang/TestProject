//
//  BitCoinStore.swift
//  TestProject
//
//  Created by Menghao Zhang on 2021-06-03.
//

import Foundation
import Combine

class BitCoinStore {

    enum State {
        case idle
        case loading
        case error(Error)
        case complete(Double)
    }

    @Published private(set) var state: State

    private let bitCoinService = BitCoinService()
    private var cancellable: Cancellable?

    init() {
        self.state = .idle
    }

    init(state: State) {
        self.state = state
    }

    func fetchBitCoinPrice() {
        state = .loading
        cancellable = bitCoinService.fetchBitCoinPrice().sink(receiveCompletion: { [weak self] completion in
            switch completion {
            case .failure(let error):
                self?.state = .error(error)
            case.finished:
                break
            }
        }, receiveValue: { bitCoinPriceIndex in
            let currentBitCoinToUSDValue = bitCoinPriceIndex.dpi.USD.rateValue
            self.state = .complete(currentBitCoinToUSDValue)
        })
    }
}
