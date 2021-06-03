//
//  ViewController.swift
//  TestProject
//
//  Created by Menghao Zhang on 2021-06-02.
//

import UIKit

class ViewController: UIViewController {
    private let stackView = UIStackView()
    private let operandsView = OperandsView()
    private let operationsView = OperationsView()
    private let outputLabel = UILabel()
    private let calculatorViewModel = CalculatorViewModel()

    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .systemBackground
        view.layoutMargins = .init(top: 4, left: 4, bottom: 4, right: 4)

        view.addSubview(outputLabel)
        view.addSubview(stackView)

        stackView.distribution = .fillEqually
        stackView.layer.borderWidth = 1
        stackView.layer.borderColor = UIColor.separator.cgColor
        stackView.addArrangedSubview(operandsView)
        stackView.addArrangedSubview(operationsView)

        operandsView.delegate = self
        operationsView.delegate = self

        outputLabel.text = calculatorViewModel.output
        outputLabel.adjustsFontSizeToFitWidth = true
        outputLabel.minimumScaleFactor = 0.5
        outputLabel.font = UIFont.boldSystemFont(ofSize: 40)
        outputLabel.textAlignment = .right

        outputLabel.translatesAutoresizingMaskIntoConstraints = false
        stackView.translatesAutoresizingMaskIntoConstraints = false

        let stackViewRatioConstraint = stackView.widthAnchor.constraint(equalTo: stackView.heightAnchor)
        stackViewRatioConstraint.priority = .defaultHigh

        NSLayoutConstraint.activate([
            outputLabel.topAnchor.constraint(greaterThanOrEqualTo: view.safeAreaLayoutGuide.topAnchor),
            outputLabel.leadingAnchor.constraint(equalTo: view.layoutMarginsGuide.leadingAnchor),
            outputLabel.trailingAnchor.constraint(equalTo: view.layoutMarginsGuide.trailingAnchor),
            outputLabel.heightAnchor.constraint(equalToConstant: 80),

            stackViewRatioConstraint,
            stackView.topAnchor.constraint(equalTo: outputLabel.bottomAnchor),
            stackView.leadingAnchor.constraint(equalTo: view.layoutMarginsGuide.leadingAnchor),
            stackView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            stackView.trailingAnchor.constraint(equalTo: view.layoutMarginsGuide.trailingAnchor)
        ])
    }
}

extension ViewController: OperandsViewDelegate {
    func operandsView(_ view: OperandsView, didTap number: Int) {
        calculatorViewModel.insert(number: number)
        outputLabel.text = calculatorViewModel.output
    }

    func operandsViewDidTapDecimal(_ view: OperandsView) {
        // TODO:
    }

    func operandsViewDidTapClear(_ view: OperandsView) {
        calculatorViewModel.clear()
        outputLabel.text = calculatorViewModel.output
    }
}

extension ViewController: OperationsViewDelegate {
    func operationsView(_ view: OperationsView, didTap operation: Operation) {
        calculatorViewModel.insert(operation: operation)
        outputLabel.text = calculatorViewModel.output
    }

    func operationsViewDidTapEqual(_ view: OperationsView) {
        calculatorViewModel.insertEqual()
        outputLabel.text = calculatorViewModel.output
    }
}
