//
//  File.swift
//  
//
//  Created by Menghao Zhang on 2021-06-06.
//

import Foundation
import Combine

class RESTService {
    private let urlSession: URLSession = .shared
    private let decoder = JSONDecoder()

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
