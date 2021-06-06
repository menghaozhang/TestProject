//
//  BitCoinService.swift
//  TestProject
//
//  Created by Menghao Zhang on 2021-06-03.
//

import Foundation
import Combine

protocol BitCoinService {
    func fetchBitCoinPrice() -> AnyPublisher<BitCoinPriceIndex, Error>
}

final class RESTBitCoinService: RESTService, BitCoinService {
    private let baseUrl = URL(string: "https://api.coindesk.com/v1/bpi/currentprice.json")!

    func fetchBitCoinPrice() -> AnyPublisher<BitCoinPriceIndex, Error> {
        let urlRequest = URLRequest(url: baseUrl)
        return performRequest(urlRequest: urlRequest)
    }
}
