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

    private let operations: [Operation] = [.plus, .minus, .times, .divide, .sin, .cos, .bitcoin]
    private let disabledOperations: [Operation]

    private var operationButtons: [InputButton] {
        return [row1, row2, row3, row4].flatMap({ $0.arrangedSubviews.compactMap({ $0 as? InputButton }) })
    }

    var numberColor: UIColor = .label {
        didSet {
            for button in operationButtons {
                button.tintColor = numberColor
            }
        }
    }

    init(disabledOperations: [Operation] = []) {
        self.disabledOperations = disabledOperations

        super.init(frame: .zero)

        setup()
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func setup() {
        layoutMargins = .zero

        for operation in operations {
            if disabledOperations.contains(operation) {
                let emptyView = UIView()
                emptyView.backgroundColor = .systemGroupedBackground
                emptyView.layer.borderWidth = 1
                emptyView.layer.borderColor = UIColor.separator.cgColor
                [row1, row2, row3, row4]
                    .first(where: { $0.arrangedSubviews.count < 2 })?
                    .addArrangedSubview(emptyView)
                continue
            }
            let operationInputButton = OperationInputButton(operation: operation)
            operationInputButton.backgroundColor = .systemGroupedBackground
            operationInputButton.tintColor = .label
            operationInputButton.title = operation.rawValue
            operationInputButton.layer.borderWidth = 1
            operationInputButton.layer.borderColor = UIColor.separator.cgColor
            operationInputButton.addTarget(self, action: #selector(enterOperation(_:)), for: .touchUpInside)
            [row1, row2, row3, row4]
                .first(where: { $0.arrangedSubviews.count < 2 })?
                .addArrangedSubview(operationInputButton)
        }

        let equalButton = InputButton()
        equalButton.backgroundColor = .systemGroupedBackground
        equalButton.tintColor = .label
        equalButton.layer.borderWidth = 1
        equalButton.layer.borderColor = UIColor.separator.cgColor
        equalButton.title = "="
        equalButton.addTarget(self, action: #selector(enterEqual(_:)), for: .touchUpInside)
        row4.addArrangedSubview(equalButton)

        for row in [row1, row2, row3, row4] {
            row.axis = .horizontal
            row.distribution = .fillEqually
            stackView.addArrangedSubview(row)
        }

        stackView.axis = .vertical
        stackView.distribution = .fillEqually
        stackView.isLayoutMarginsRelativeArrangement = true
        stackView.layoutMargins = .init(top: 1, left: 0, bottom: 0, right: 0)
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
