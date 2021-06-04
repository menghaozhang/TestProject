//
//  OperationInputButton.swift
//  TestProject
//
//  Created by Menghao Zhang on 2021-06-02.
//

#if os(iOS)
import UIKit

final class OperationInputButton: InputButton {
    var operation: Operation

    init(operation: Operation) {
        self.operation = operation

        super.init(frame: CGRect(x: 0, y: 0, width: 40, height: 40))

        title = operation.rawValue
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
#endif
