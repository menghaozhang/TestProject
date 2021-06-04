//
//  BitCoinService.swift
//  TestProject
//
//  Created by Menghao Zhang on 2021-06-03.
//

import Foundation
import Combine

final class BitCoinService {
    private let urlSession: URLSession = .shared
    private let decoder = JSONDecoder()
    private let baseUrl = URL(string: "https://api.coindesk.com/v1/bpi/currentprice.json")!

    func fetchBitCoinPrice() -> AnyPublisher<BitCoinPriceIndex, Error> {
        let urlRequest = URLRequest(url: baseUrl)
        return performRequest(urlRequest: urlRequest)
    }

    func performRequest<Object: Decodable>(urlRequest: URLRequest) -> AnyPublisher<Object, Error> {
        return urlSession
            .dataTaskPublisher(for: urlRequest)
            .tryMap { element -> Data in
                guard let response = element.response as? HTTPURLResponse, response.statusCode == 200 else {
                    throw URLError(.badServerResponse)
                }
                return element.data
            }
            .decode(type: Object.self, decoder: decoder)
            .receive(on: DispatchQueue.main)
            .eraseToAnyPublisher()
    }
}
