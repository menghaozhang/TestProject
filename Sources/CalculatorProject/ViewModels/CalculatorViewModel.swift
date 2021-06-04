//
//  CalculatorViewModel.swift
//  TestProject
//
//  Created by Menghao Zhang on 2021-06-02.
//

#if os(iOS)
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
        numberFormatter.maximumFractionDigits = 10
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
            let result = lhsValue.flatMap({ numberFormatter.string(from: NSNumber(value: $0)) }) ?? String()
            output = .success(result)
        } else {
            rhsValue = (rhsValue ?? 0) * 10 + Double(number)
            let result = rhsValue.flatMap({ numberFormatter.string(from: NSNumber(value: $0)) }) ?? String()
            output = .success(result)
        }
    }

    func insert(operation: Operation) {
        if rhsValue != nil {
            insertEqual()
        }
        currentOperation = operation
        output = .success(operation.rawValue)
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
            guard let divisor = rhsValue ?? lhsValue, divisor != 0 else {
                output = .failure(.divideByZero)
                return
            }
            result = (lhsValue ?? 0) / divisor
        case .sin:
            let radius = radians(from: Double(rhsValue ?? lhsValue ?? 0))
            result = sin(radius)
        case .cos:
            let radius = radians(from: Double(rhsValue ?? lhsValue ?? 0))
            result = cos(radius)
        case .bitcoin:
            bitCoinStore.fetchBitCoinPrice()
            return
        }

        self.currentOperation = nil
        rhsValue = nil
        lhsValue = result

        let outputString = numberFormatter.string(from: NSNumber(value: result)) ?? String(result)
        output = .success(outputString)
    }

    func clear() {
        if rhsValue != nil {
            rhsValue = nil
            output = .success("0")
        } else if currentOperation != nil {
            currentOperation = nil
            let outputString = lhsValue.flatMap({ numberFormatter.string(from: NSNumber(value: $0)) }) ?? String()
            output = .success(outputString)
        } else {
            lhsValue = nil
            output = .success("0")
        }
    }

    private func update(state: BitCoinStore.State) {
        switch state {
        case .idle:
            break
        case .loading:
            output = .success("Loading...")
        case .error:
            output = .failure(.bitcoinPriceUnavailable)
            currentOperation = nil
            rhsValue = nil
        case .complete(let bitcoinValue):
            if currentOperation == .bitcoin {
                let result = bitcoinValue * (rhsValue ?? lhsValue ?? 0)
                currentOperation = nil
                rhsValue = nil
                lhsValue = result

                let outputString = numberFormatter.string(from: NSNumber(value: result)) ?? String(result)
                output = .success(outputString)
            }
        }
    }

    func radians(from degree: Double) -> Double {
        return degree * .pi / 180
    }
}
#endif
