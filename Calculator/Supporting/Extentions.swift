//
//  Extentions.swift
//  Calculator
//
//  Created by Marwa Awad on 08.03.2025.
//

import Foundation

extension Double {
    var toInt: Int? { return Int(self) }
}

extension String {
    var toDouple: Double? { return Double(self) }
}

extension FloatingPoint {
    var isInteger: Bool {
        return rounded() == self
    }
}
