//
//  CalculatorOperaion.swift
//  Calculator
//
//  Created by Marwa Awad on 08.03.2025.
//

import Foundation

enum CalculatorOperaion {
    case add
    case subtract
    case multiply
    case divide
    
    var title: String {
        switch self {
        case .add:
            return "+"
        case .subtract:
            return "-"
        case .multiply:
            return "x"
        case .divide:
            return "÷"
        }
    }
}
