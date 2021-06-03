//
//  CalculatorViewModel.swift
//  TestProject
//
//  Created by Menghao Zhang on 2021-06-02.
//

import UIKit
import Combine

class CalculatorViewModel {
    enum CalculatorError: CustomStringConvertible, Error {
        case divideByZero
        case bitcoinPriceUnavailable

        var description: String {
            switch self {
            case .divideByZero:
                return "Cannot have 0 as divisor."
            case .bitcoinPriceUnavailable:
                return "Cannot fetch bitcoin price from remote."
            }
        }
    }

    @Published private(set) var output: Result<String?, CalculatorError> = .success("0")

    var lhsValue: Double?
    var rhsValue: Double?

    private var bitCoinStore = BitCoinStore()

    private var cancellable: Cancellable?
    private var currentOperation: Operation?
    private var numberFormatter: NumberFormatter {
        let numberFormatter = NumberFormatter()
        numberFormatter.minimumFractionDigits = 0
        numberFormatter.maximumFractionDigits = 20
        return numberFormatter
    }

    init() {
        cancellable = bitCoinStore.$state.sink { [weak self] state in
            self?.update(state: state)
        }
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

    func insertEqual() {
        guard let currentOperation = currentOperation else {
            return
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
            bitCoinStore.fetchBitCoinPrice()
            return
        }

        self.currentOperation = nil
        rhsValue = nil
        lhsValue = result

        output = numberFormatter.string(from: NSNumber(value: result)) ?? String(result)
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

    private func update(state: BitCoinStore.State) {
        switch state {
        case .idle:
            break
        case .loading:
            break
        case .error(let error):
            print(error)
        case .complete(let bitcoinValue):
            print(bitcoinValue)
            if currentOperation == .bitcoin {
                let result = bitcoinValue * (rhsValue ?? lhsValue ?? 0)
                self.currentOperation = nil
                rhsValue = nil
                lhsValue = result

                output = numberFormatter.string(from: NSNumber(value: result)) ?? String(result)
            }
        }
    }
}
