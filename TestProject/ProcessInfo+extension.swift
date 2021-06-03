//
//  ProcessInfo+extension.swift
//  TestProject
//
//  Created by Menghao Zhang on 2021-06-03.
//

import Foundation

extension ProcessInfo {
    var disabledOperations: [Operation] {
        let disabledOperationsString = ProcessInfo.processInfo.environment["DISABLED_OPERATIONS"] ?? String()
        return Operation.allCases.filter { (disabledOperationsString.contains($0.rawValue)) }
    }
}
