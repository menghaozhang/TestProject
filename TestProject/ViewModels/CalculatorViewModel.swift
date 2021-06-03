//
//  CalculatorViewModel.swift
//  TestProject
//
//  Created by Menghao Zhang on 2021-06-02.
//

import UIKit

class CalculatorViewModel {
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

    func insert(number: Int) {
        if currentOperation == nil {
            lhsValue = (lhsValue ?? 0) * 10 + Double(number)
            output = lhsValue.flatMap({ numberFormatter.string(from: NSNumber(value: $0)) }) ?? String()
        } else {
            rhsValue = (rhsValue ?? 0) * 10 + Double(number)
            output = rhsValue.flatMap({ numberFormatter.string(from: NSNumber(value: $0)) }) ?? String()
        }
    }

    func insert(operation: Operation) {
        if currentOperation == nil {
            if rhsValue == nil {
                currentOperation = operation
            } else {
                insertEqual()
            }
        } else {
            currentOperation = operation
        }
        output = operation.rawValue
    }

    @discardableResult
    func insertEqual() -> Double {
        guard let currentOperation = currentOperation else {
            return Double(lhsValue ?? 0)
        }

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
            result = (lhsValue ?? 0) / (rhsValue ?? lhsValue ?? 0)
        case .sin:
            result = sin(Double(rhsValue ?? lhsValue ?? 0))
        case .cos:
            result = cos(Double(rhsValue ?? lhsValue ?? 0))
        case .bitcoin:
            // TODO:
            result = 1000.0 * Double(rhsValue ?? lhsValue ?? 0)
        }

        self.currentOperation = nil
        rhsValue = nil
        lhsValue = result

        output = numberFormatter.string(from: NSNumber(value: result)) ?? String(result)

        return result
    }

    func clear() {
        if rhsValue != nil {
            rhsValue = nil
            output = "0"
        } else if currentOperation != nil {
            currentOperation = nil
            output = lhsValue.flatMap({ numberFormatter.string(from: NSNumber(value: $0)) }) ?? String()
        } else {
            lhsValue = nil
            output = "0"
        }
    }
}
