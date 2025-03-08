//
//  CalculatorViewModel.swift
//  Calculator
//
//  Created by Marwa Awad on 05.03.2025.
//

import Foundation

class CalculatorViewModel {
    
    //MARK: - Variables
    private(set) lazy var calculatorHeaderLabel: String = "ß"
    
    //MARK: - TableView DataSource array
    let calculatorButtonCells: [CalculatorButtons] = [
        .init(calculatorButton: .allClear),
        .init(calculatorButton: .allClear),
        .init(calculatorButton: .plusMinus),
        .init(calculatorButton: .percentage),
        .init(calculatorButton: .divide),
        .init(calculatorButton: .number(7)),
        .init(calculatorButton: .number(8)),
        .init(calculatorButton: .number(9)),
        .init(calculatorButton: .multiply),
        .init(calculatorButton: .number(4)),
        .init(calculatorButton: .number(5)),
        .init(calculatorButton: .number(6)),
        .init(calculatorButton: .subtract),
        .init(calculatorButton: .number(1)),
        .init(calculatorButton: .number(2)),
        .init(calculatorButton: .number(3)),
        .init(calculatorButton: .add),
        .init(calculatorButton: .number(0)),
        .init(calculatorButton: .decimal),
        .init(calculatorButton: .equals),
    ]
   
    
   
}
