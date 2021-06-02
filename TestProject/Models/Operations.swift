//
//  Operation.swift
//  TestProject
//
//  Created by Menghao Zhang on 2021-06-02.
//

import Foundation

struct Operations: OptionSet {
    let rawValue: Int

    static let plus = Operations(rawValue: 1 << 0)
    static let minus = Operations(rawValue: 1 << 1)
    static let times = Operations(rawValue: 1 << 2)
    static let divide = Operations(rawValue: 1 << 3)
    static let sin = Operations(rawValue: 1 << 4)
    static let cos = Operations(rawValue: 1 << 5)

    static let all: Operations = [.plus, .minus, .times, .divide, .sin, .cos]

    init(rawValue: Int) {
        self.rawValue = rawValue
    }
}
