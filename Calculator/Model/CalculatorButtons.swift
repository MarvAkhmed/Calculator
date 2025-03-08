//
//  CalculatorButton.swift
//  Calculator
//
//  Created by Marwa Awad on 05.03.2025.
//

import UIKit

enum CalculatorButtons {
    case allClear
    case plusMinus
    case percentage
    case divide
    case multiply
    case subtract
    case add
    case equals
    case number(Int)
    case decimal
    
    init(calculatorButton: CalculatorButtons) {
        switch calculatorButton {
        case .allClear, .plusMinus, .percentage, .divide, .multiply, .add, .equals, .decimal, .subtract:
            self = calculatorButton
        case .number(let int):
            if int.description.count == 1 {
                self = calculatorButton
            }else {
                fatalError("CalculatorButton.number Int was not 1 digit during init")
            }
        }
    }
}

//MARK: - button title labels
extension CalculatorButtons {
    var title: String {
        switch self {
        case .allClear:
            return "AC"
        case .plusMinus:
            return "+/-"
        case .percentage:
            return "%"
        case .divide:
            return "÷"
        case .multiply:
            return "x"
        case .subtract:
            return "-"
        case .add:
            return "+"
        case .equals:
            return "="
        case .number(let int):
            return int.description
        case .decimal:
            return "."
        }
    }
    //MARK: - Button Colors
    var color: UIColor {
        switch self {
        case .allClear, .plusMinus, .percentage:
            return .lightGray
            
        case .divide, .multiply, .subtract, .add, .equals:
            return .systemOrange
            
        case .number, .decimal:
            return .darkGray
        }
    }
    //MARK: - Button Colors on select
    var selectedColor: UIColor? {
        switch self {
        case .allClear, .plusMinus, .percentage, .equals, .number, .decimal:
            return nil
            
        case .divide, .multiply, .subtract, .add:
            return .white
        }
    }
    
}
