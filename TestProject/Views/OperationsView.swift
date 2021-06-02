//
//  OperationsView.swift
//  TestProject
//
//  Created by Menghao Zhang on 2021-06-02.
//

import UIKit

protocol OperationsViewDelegate: AnyObject {
    func operationsView(_ view: OperationsView, didTap operation: Operation)
    func operationsViewDidTapEqual(_ view: OperationsView)
}

final class OperationsView: UIView {
    weak var delegate: OperationsViewDelegate?

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
        backgroundColor = .white
        layoutMargins = .zero

        for operation in operations {
            switch operation {
            case .plus:
                let plusButton = OperationInputButton(operation: operation)
                plusButton.title = operation.rawValue
                plusButton.addTarget(self, action: #selector(enterOperation(_:)), for: .touchUpInside)
                row1.addArrangedSubview(plusButton)
            case .minus:
                let minusButton = OperationInputButton(operation: operation)
                minusButton.title = operation.rawValue
                minusButton.addTarget(self, action: #selector(enterOperation(_:)), for: .touchUpInside)
                row1.addArrangedSubview(minusButton)
            case .times:
                let timesButton = OperationInputButton(operation: operation)
                timesButton.title = operation.rawValue
                timesButton.addTarget(self, action: #selector(enterOperation(_:)), for: .touchUpInside)
                row2.addArrangedSubview(timesButton)
            case .divide:
                let divideButton = OperationInputButton(operation: operation)
                divideButton.title = operation.rawValue
                divideButton.addTarget(self, action: #selector(enterOperation(_:)), for: .touchUpInside)
                row2.addArrangedSubview(divideButton)
            case .sin:
                let sinButton = OperationInputButton(operation: operation)
                sinButton.title = operation.rawValue
                sinButton.addTarget(self, action: #selector(enterOperation(_:)), for: .touchUpInside)
                row3.addArrangedSubview(sinButton)
            case .cos:
                let cosButton = OperationInputButton(operation: operation)
                cosButton.title = operation.rawValue
                cosButton.addTarget(self, action: #selector(enterOperation(_:)), for: .touchUpInside)
                row3.addArrangedSubview(cosButton)
            }
        }

        let equalButton = InputButton()
        equalButton.title = "="
        equalButton.addTarget(self, action: #selector(enterEqual(_:)), for: .touchUpInside)
        row4.addArrangedSubview(equalButton)

        let rows = [row1, row2, row3, row4]
        for row in rows {
            row.axis = .horizontal
            row.distribution = .fillEqually
            row.spacing = 1
            stackView.addArrangedSubview(row)
        }

        stackView.axis = .vertical
        stackView.distribution = .fillEqually
        stackView.spacing = 1
        stackView.isLayoutMarginsRelativeArrangement = true
        stackView.layoutMargins = .zero
        stackView.layoutMargins.top = 1
        stackView.translatesAutoresizingMaskIntoConstraints = false
        addSubview(stackView)

        clipsToBounds = false

        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(equalTo: topAnchor),
            stackView.leadingAnchor.constraint(equalTo: leadingAnchor),
            stackView.trailingAnchor.constraint(equalTo: trailingAnchor),
            stackView.bottomAnchor.constraint(equalTo: bottomAnchor),
        ])
    }

    @objc func enterOperation(_ sender: OperationInputButton) {
        delegate?.operationsView(self, didTap: sender.operation)
    }

    @objc func enterEqual(_ sender: Any) {
        delegate?.operationsViewDidTapEqual(self)
    }
}
