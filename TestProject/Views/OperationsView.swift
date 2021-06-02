//
//  OperationsView.swift
//  TestProject
//
//  Created by Menghao Zhang on 2021-06-02.
//

import UIKit

final class OperationsView: UIView {
    private let stackView = UIStackView()
    private let row1 = UIStackView()
    private let row2 = UIStackView()
    private let row3 = UIStackView()
    private let row4 = UIStackView()

    private var operations: [Operation] = [.plus, .minus, .times, .divide, .sin, .cos]

    override init(frame: CGRect) {
        super.init(frame: frame)

        setup()
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func setup() {
        for operation in operations {
            switch operation {
            case .plus:
                let plusButton = InputButton()
                plusButton.title = operation.rawValue
                plusButton.addTarget(self, action: #selector(beginEnterNumber), for: .touchDown)
                plusButton.addTarget(self, action: #selector(enterPlus(_:)), for: .touchUpInside)
                row1.addArrangedSubview(plusButton)
            case .minus:
                let minusButton = InputButton()
                minusButton.title = operation.rawValue
                minusButton.addTarget(self, action: #selector(beginEnterNumber), for: .touchDown)
                minusButton.addTarget(self, action: #selector(enterMinus(_:)), for: .touchUpInside)
                row2.addArrangedSubview(minusButton)
            case .times:
                let timesButton = InputButton()
                timesButton.title = operation.rawValue
                timesButton.addTarget(self, action: #selector(beginEnterNumber), for: .touchDown)
                timesButton.addTarget(self, action: #selector(enterTimes(_:)), for: .touchUpInside)
                row3.addArrangedSubview(timesButton)
            case .divide:
                let divideButton = InputButton()
                divideButton.title = operation.rawValue
                divideButton.addTarget(self, action: #selector(beginEnterNumber), for: .touchDown)
                divideButton.addTarget(self, action: #selector(enterDivide(_:)), for: .touchUpInside)
                row4.addArrangedSubview(divideButton)
            case .sin:
                let sinButton = InputButton()
                sinButton.title = operation.rawValue
                sinButton.addTarget(self, action: #selector(beginEnterNumber), for: .touchDown)
                sinButton.addTarget(self, action: #selector(enterSin(_:)), for: .touchUpInside)
                row3.addArrangedSubview(sinButton)
            case .cos:
                let cosButton = InputButton()
                cosButton.title = operation.rawValue
                cosButton.addTarget(self, action: #selector(beginEnterNumber), for: .touchDown)
                cosButton.addTarget(self, action: #selector(enterCos(_:)), for: .touchUpInside)
                row4.addArrangedSubview(cosButton)
            }
        }
    }

    @objc private func beginEnterNumber(_ sender: Any) {
        UIDevice.current.playInputClick()
    }

    @objc func enterPlus(_ sender: Any) {
        // TODO
    }

    @objc func enterMinus(_ sender: Any) {
        // TODO
    }

    @objc func enterTimes(_ sender: Any) {
        // TODO
    }

    @objc func enterDivide(_ sender: Any) {
        // TODO
    }

    @objc func enterSin(_ sender: Any) {
        // TODO
    }

    @objc func enterCos(_ sender: Any) {
        // TODO
    }
}
