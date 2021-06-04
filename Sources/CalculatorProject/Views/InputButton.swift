//
//  InputButton.swift
//  TestProject
//
//  Created by Menghao Zhang on 2021-06-02.
//

#if os(iOS)
import UIKit

class InputButton: UIControl {
    private let label = UILabel()

    var title: String? {
        get { return label.text }
        set { label.text = newValue }
    }

    convenience init() {
        self.init(frame: CGRect(x: 0, y: 0, width: 40, height: 40))
    }

    override init(frame: CGRect) {
        super.init(frame: frame)

        label.textColor = tintColor
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        addSubview(label)

        clipsToBounds = true

        NSLayoutConstraint.activate([
            label.leadingAnchor.constraint(equalTo: leadingAnchor),
            label.topAnchor.constraint(equalTo: topAnchor),
            label.trailingAnchor.constraint(equalTo: trailingAnchor),
            label.bottomAnchor.constraint(equalTo: bottomAnchor),
        ])
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func tintColorDidChange() {
        super.tintColorDidChange()

        label.textColor = tintColor
    }

    override var isHighlighted: Bool {
        didSet {
            label.textColor = isHighlighted ? tintColor.withAlphaComponent(0.5) : tintColor
        }
    }
}
#endif
