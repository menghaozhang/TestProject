//
//  CalculatorViewModel.swift
//  TestProject
//
//  Created by Menghao Zhang on 2021-06-02.
//

import UIKit

struct CalculatorViewModel {
    var lhsValue: Double?
    var rhsValue: Double?
    var output = "0"

    private var currentOperation: Operation?
    private var numberFormatter: NumberFormatter {
        let numberFormatter = NumberFormatter()
        numberFormatter.minimumFractionDigits = 0
        numberFormatter.maximumFractionDigits = 20
        return numberFormatter
    }

    mutating func insert(number: Int) {
        if currentOperation == nil {
            self.lhsValue = (lhsValue ?? 0) * 10 + Double(number)
            self.output = lhsValue.flatMap({ numberFormatter.string(from: NSNumber(value: $0)) }) ?? String()
        } else {
            self.rhsValue = (rhsValue ?? 0) * 10 + Double(number)
            self.output = rhsValue.flatMap({ numberFormatter.string(from: NSNumber(value: $0)) }) ?? String()
        }
    }

    mutating func insert(operation: Operation) {
        if currentOperation == nil {
            if rhsValue == nil {
                self.currentOperation = operation
            } else {
                equal()
            }
        } else {
            currentOperation = operation
        }
        self.output = operation.rawValue
    }

    mutating func equal() -> Double {
        guard let currentOperation = currentOperation else { return Double(lhsValue ?? 0)}

        var result: Double
        switch currentOperation {
        case .plus:
            result = (lhsValue ?? 0) + (rhsValue ?? lhsValue ?? 0)
        case .minus:
            result = (lhsValue ?? 0) - (rhsValue ?? lhsValue ?? 0)
        case .times:
            result = (lhsValue ?? 0) * (rhsValue ?? lhsValue ?? 0)
        case .divide:
            // TODO: divide zero error
            result = (lhsValue ?? 0) / (rhsValue ?? lhsValue ?? 1)
        case .sin:
            result = sin(Double(lhsValue ?? 0))
        case .cos:
            result = cos(Double(lhsValue ?? 0))
        }

        self.currentOperation = nil
        self.rhsValue = nil
        self.lhsValue = result

        self.output = numberFormatter.string(from: NSNumber(value: result)) ?? String(result)

        return result
    }
}
