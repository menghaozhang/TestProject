//
//  ViewController.swift
//  TestProject
//
//  Created by Menghao Zhang on 2021-06-02.
//

import UIKit

class ViewController: UIViewController {
    private var stackView = UIStackView()
    private var operandsView = OperandsView()
    private var operationsView = OperationsView()
    private let outputLabel = UILabel()

    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .systemBackground

        view.addSubview(outputLabel)
        view.addSubview(stackView)

        stackView.distribution = .fillEqually
        stackView.addArrangedSubview(operandsView)
        stackView.addArrangedSubview(operationsView)

        outputLabel.font = UIFont.boldSystemFont(ofSize: 40)
        outputLabel.textAlignment = .right

        outputLabel.translatesAutoresizingMaskIntoConstraints = false
        stackView.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            outputLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            outputLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            outputLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            outputLabel.heightAnchor.constraint(equalToConstant: 80),

            stackView.topAnchor.constraint(equalTo: outputLabel.bottomAnchor),
            stackView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            stackView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            stackView.trailingAnchor.constraint(equalTo: view.trailingAnchor)
        ])
    }
}

