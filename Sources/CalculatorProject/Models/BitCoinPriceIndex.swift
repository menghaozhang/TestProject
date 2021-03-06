//
//  BitCoinPriceIndex.swift
//  TestProject
//
//  Created by Menghao Zhang on 2021-06-03.
//

import Foundation

struct BitCoinPriceIndex: Decodable {
    var bpi: CurrencyValueIndex
}

struct CurrencyValueIndex: Decodable {
    var USD: CurrencyValue
    var GBP: CurrencyValue
    var EUR: CurrencyValue
}

struct CurrencyValue: Decodable {
    var code: String
    var symbol: String
    var description: String
    var rateValue: Double

    private enum CodingKeys: String, CodingKey {
        case code
        case symbol
        case description
        case rateValue = "rate_float"
    }
}
