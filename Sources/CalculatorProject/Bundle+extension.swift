//
//  Bundle+extension.swift
//  
//
//  Created by Menghao Zhang on 2021-06-06.
//

import Foundation

extension Bundle {
    static let calculatorColors = Bundle.module.url(forResource: "Colors", withExtension: "bundle").flatMap(Bundle.init(url:)) ?? Bundle.module
}
