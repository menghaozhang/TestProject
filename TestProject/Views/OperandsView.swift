//
//  OperandsView.swift
//  TestProject
//
//  Created by Menghao Zhang on 2021-06-02.
//

import UIKit

class OperandsView: UIView {
    private let stackView = UIStackView()
    private let row1 = UIStackView()
    private let row2 = UIStackView()
    private let row3 = UIStackView()
    private let row4 = UIStackView()

    private let bottomSpaceView = UIView()
    private let deleteButton = InputButton()
    private let decimalButton = InputButton()

    private var numberButtons: [InputButton] {
        return [row1, row2, row3, row4].flatMap({ $0.arrangedSubviews.compactMap({ $0 as? InputButton }) })
    }

    var numberColor: UIColor = .white {
        didSet {
            deleteButton.tintColor = numberColor
            decimalButton.tintColor = numberColor
            for button in numberButtons {
                button.tintColor = numberColor
            }
        }
    }

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

        stackView.axis = .vertical
        stackView.distribution = .fillEqually
        stackView.spacing = 1

        for number in 1...3 {
            let button = InputButton()
            button.title = String(number)
            button.addTarget(self, action: #selector(beginEnterNumber), for: .touchDown)
            button.addTarget(self, action: #selector(enterOperand(_:)), for: .touchUpInside)
            row3.addArrangedSubview(button)
        }

        for number in 4...6 {
            let button = InputButton()
            button.title = String(number)
            button.addTarget(self, action: #selector(beginEnterNumber), for: .touchDown)
            button.addTarget(self, action: #selector(enterOperand(_:)), for: .touchUpInside)
            row2.addArrangedSubview(button)
        }

        for number in 7...9 {
            let button = InputButton()
            button.title = String(number)
            button.addTarget(self, action: #selector(beginEnterNumber), for: .touchDown)
            button.addTarget(self, action: #selector(enterOperand(_:)), for: .touchUpInside)
            row1.addArrangedSubview(button)
        }

        decimalButton.title = Locale.current.decimalSeparator ?? "."
        decimalButton.addTarget(self, action: #selector(beginEnterNumber), for: .touchDown)
        decimalButton.addTarget(self, action: #selector(enterDecimal(_:)), for: .touchUpInside)
        row4.addArrangedSubview(decimalButton)

        let zeroButton = InputButton()
        zeroButton.title = "0"
        zeroButton.addTarget(self, action: #selector(beginEnterNumber), for: .touchDown)
        zeroButton.addTarget(self, action: #selector(enterOperand(_:)), for: .touchUpInside)
        row4.addArrangedSubview(zeroButton)

        deleteButton.title = "c"
        deleteButton.addTarget(self, action: #selector(beginEnterNumber), for: .touchDown)
        deleteButton.addTarget(self, action: #selector(deleteOperand(_:)), for: .touchUpInside)
        row4.addArrangedSubview(deleteButton)

        let rows = [row1, row2, row3, row4]
        for row in rows {
            row.axis = .horizontal
            row.distribution = .fillEqually
            row.spacing = 1
            stackView.addArrangedSubview(row)
        }

        stackView.isLayoutMarginsRelativeArrangement = true
        stackView.layoutMargins = .zero
        stackView.layoutMargins.top = 1
        stackView.translatesAutoresizingMaskIntoConstraints = false
        addSubview(stackView)

        bottomSpaceView.translatesAutoresizingMaskIntoConstraints = false
        bottomSpaceView.isUserInteractionEnabled = false
        bottomSpaceView.backgroundColor = tintColor
        addSubview(bottomSpaceView)

        clipsToBounds = false

        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(equalTo: topAnchor),
            stackView.leadingAnchor.constraint(equalTo: leadingAnchor),
            stackView.trailingAnchor.constraint(equalTo: trailingAnchor),
            stackView.bottomAnchor.constraint(equalTo: bottomAnchor),

            bottomSpaceView.topAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor, constant: 1),
            bottomSpaceView.leadingAnchor.constraint(equalTo: leadingAnchor),
            bottomSpaceView.trailingAnchor.constraint(equalTo: trailingAnchor),
            bottomSpaceView.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
    }

    @objc private func beginEnterNumber(_ sender: Any) {
        UIDevice.current.playInputClick()
    }

    @objc private func enterOperand(_ sender: Any) {
        // TODO
    }

    @objc private func enterDecimal(_ sender: Any) {
        // TODO
    }

    @objc private func deleteOperand(_ sender: Any) {
        // TODO
    }
}
