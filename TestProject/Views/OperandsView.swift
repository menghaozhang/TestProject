//
//  OperandsView.swift
//  TestProject
//
//  Created by Menghao Zhang on 2021-06-02.
//

import UIKit

protocol OperandsViewDelegate: AnyObject {
    func operandsView(_ view: OperandsView, didTap number: Int)
    func operandsViewDidTapDecimal(_ view: OperandsView)
    func operandsViewDidTapClear(_ view: OperandsView)
}

final class OperandsView: UIView {
    weak var delegate: OperandsViewDelegate?

    private let stackView = UIStackView()
    private let row1 = UIStackView()
    private let row2 = UIStackView()
    private let row3 = UIStackView()
    private let row4 = UIStackView()

    private let deleteButton = InputButton()
    private let decimalButton = InputButton()

    private var numberButtons: [InputButton] {
        return [row1, row2, row3, row4].flatMap({ $0.arrangedSubviews.compactMap({ $0 as? InputButton }) })
    }

    var numberColor: UIColor = .label {
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

        for number in 1...9 {
            let button = InputButton()
            button.backgroundColor = .systemGroupedBackground
            button.tintColor = .label
            button.layer.borderWidth = 1
            button.layer.borderColor = UIColor.separator.cgColor
            button.title = String(number)
            button.addTarget(self, action: #selector(enterOperand(_:)), for: .touchUpInside)
            [row3, row2, row1]
                .first { $0.arrangedSubviews.count < 3 }?
                .addArrangedSubview(button)
        }

        decimalButton.title = Locale.current.decimalSeparator ?? "."
        decimalButton.addTarget(self, action: #selector(enterDecimal(_:)), for: .touchUpInside)
        row4.addArrangedSubview(decimalButton)

        let zeroButton = InputButton()
        zeroButton.title = "0"
        zeroButton.addTarget(self, action: #selector(enterOperand(_:)), for: .touchUpInside)
        row4.addArrangedSubview(zeroButton)

        deleteButton.title = "clear"
        deleteButton.addTarget(self, action: #selector(deleteOperand(_:)), for: .touchUpInside)
        row4.addArrangedSubview(deleteButton)

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

    @objc private func enterOperand(_ sender: InputButton) {
        if let text = sender.title, let inputNumber = Int(text) {
            delegate?.operandsView(self, didTap: inputNumber)
        }
    }

    @objc private func enterDecimal(_ sender: Any) {
        delegate?.operandsViewDidTapDecimal(self)
    }

    @objc private func deleteOperand(_ sender: Any) {
        delegate?.operandsViewDidTapClear(self)
    }
}
