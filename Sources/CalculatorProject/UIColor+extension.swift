//
//  UIColor+extension.swift
//  
//
//  Created by Menghao Zhang on 2021-06-06.
//

#if os(iOS)
import UIKit

extension UIColor {
    static var accentBackgroundColor: UIColor? {
        return UIColor(named: "AccentBackgroundColor", in: .calculatorColors, compatibleWith: nil)
    }
}
#endif
