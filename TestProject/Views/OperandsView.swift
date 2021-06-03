//
//  OperandsView.swift
//  TestProject
//
//  Created by Menghao Zhang on 2021-06-02.
//

import UIKit

protocol OperandsViewDelegate: AnyObject {
    func operandsView(_ view: OperandsView, didTap number: Int)
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

    private var numberButtons: [InputButton] {
        return [row1, row2, row3, row4].flatMap({ $0.arrangedSubviews.compactMap({ $0 as? InputButton }) })
    }

    var numberColor: UIColor = .label {
        didSet {
            deleteButton.tintColor = numberColor
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


        let zeroButton = InputButton()
        zeroButton.backgroundColor = .systemGroupedBackground
        zeroButton.tintColor = .label
        zeroButton.layer.borderWidth = 1
        zeroButton.layer.borderColor = UIColor.separator.cgColor
        zeroButton.title = "0"
        zeroButton.addTarget(self, action: #selector(enterOperand(_:)), for: .touchUpInside)
        row4.addArrangedSubview(zeroButton)

        deleteButton.title = "clear"
        deleteButton.backgroundColor = .systemGroupedBackground
        deleteButton.tintColor = .label
        deleteButton.layer.borderWidth = 1
        deleteButton.layer.borderColor = UIColor.separator.cgColor
        deleteButton.addTarget(self, action: #selector(deleteOperand(_:)), for: .touchUpInside)
        row4.addArrangedSubview(deleteButton)

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

    @objc private func enterOperand(_ sender: InputButton) {
        if let text = sender.title, let inputNumber = Int(text) {
            delegate?.operandsView(self, didTap: inputNumber)
        }
    }

    @objc private func deleteOperand(_ sender: Any) {
        delegate?.operandsViewDidTapClear(self)
    }
}
