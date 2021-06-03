//
//  ViewController.swift
//  TestProject
//
//  Created by Menghao Zhang on 2021-06-02.
//

import UIKit
import Combine

class ViewController: UIViewController {
    private let stackView = UIStackView()
    private let operandsView = OperandsView()
    private let operationsView: OperationsView
    private let outputLabel = UILabel()
    private let calculatorViewModel = CalculatorViewModel()

    private var cancellable: Cancellable?

    init() {
        operationsView = OperationsView(disabledOperations: ProcessInfo.processInfo.disabledOperations)

        super.init(nibName: nil, bundle: nil)

        cancellable = calculatorViewModel.$output.receive(on: DispatchQueue.main).sink { [weak self] output in
            do {
                let string = try output.get()
                self?.outputLabel.text = string
            } catch let error as CalculatorViewModel.CalculatorError {
                let alertController = UIAlertController(title: "Error", message: error.description, preferredStyle: .alert)
                alertController.addAction(.init(title: "OK", style: .default, handler: { _ in
                    alertController.dismiss(animated: true)
                }))
                self?.present(alertController, animated: true)
            }
            catch {
                fatalError()
            }
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
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
    }

    func operandsViewDidTapClear(_ view: OperandsView) {
        calculatorViewModel.clear()
    }
}

extension ViewController: OperationsViewDelegate {
    func operationsView(_ view: OperationsView, didTap operation: Operation) {
        calculatorViewModel.insert(operation: operation)
    }

    func operationsViewDidTapEqual(_ view: OperationsView) {
        calculatorViewModel.insertEqual()
    }
}
