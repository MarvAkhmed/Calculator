//
//  CalculatorViewModel.swift
//  Calculator
//
//  Created by Marwa Awad on 05.03.2025.
//

import Foundation

enum CurrentNumber {
    case firstNumber
    case secondNumber
}
 
class  CalculatorViewModel {
    
    var updateViews: (() -> Void)?
    
    //MARK: - Variables
    private(set) lazy var calculatorHeaderLabel: String = (self.firstNumber ?? 0).description
    private(set) var currentNumber: CurrentNumber = .firstNumber
    
    private(set) var firstNumber: Int? = nil {
        didSet { self.calculatorHeaderLabel = self.firstNumber?.description ?? "0"}
    }
    private(set) var secondNumber: Int? = nil {
        didSet { self.calculatorHeaderLabel = self.secondNumber?.description ?? "0"}
    }
     
    private(set) var operation: CalculatorOperaion? = nil
    

    //MARK: - Memory Variables
    private(set) var prevNumber: Int? = nil
    private(set) var prevOperaion: CalculatorOperaion? = nil
    
    //MARK: - TableView DataSource array
    let calculatorButtonCells: [CalculatorButtons] = [
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

//MARK: - calling the logic funcions
extension CalculatorViewModel{
    public func didSelectButton(with calcButton: CalculatorButtons) {
        switch calcButton {
        case .allClear:
            self.didSelectAllClear()
        case .plusMinus:
            self.didSelectPlusMinus()
        case .percentage:
            self.didSelectPersentage()
        case .divide:
            self.didSelectOperion(with: .divide)
        case .multiply:
            self.didSelectOperion(with: .multiply)
        case .subtract:
            self.didSelectOperion(with: .subtract)
        case .add:
            self.didSelectOperion(with: .add)
        case .equals:
            self.didSelectEqualsButton()
        case .number(let number):
            self.didSelectNumber(number)
        case .decimal:
            fatalError()
        }
        self.updateViews?()
    }
}
//MARK: - printing the numbers by clicking on the buttons
extension CalculatorViewModel {
    
    
    private func didSelectNumber(_ number: Int) {
        
        if self.currentNumber == .firstNumber {
            if let firstNumber = self.firstNumber {
                var firstNumberString = self.firstNumber?.description
                firstNumberString?.append(number.description)
                self.firstNumber = Int(firstNumberString ?? "") ?? 0
            } else {
                self.firstNumber = Int(number)
                self.prevNumber = Int(number)
            }
            
            
        }else if self.currentNumber == .secondNumber {
            
            if let secondNumber = self.secondNumber {
                var secondNumberString = self.secondNumber?.description
                secondNumberString?.append(number.description)
                self.secondNumber = Int(secondNumberString ?? "") ?? 0
                
            }else {
                self.secondNumber = Int(number)
                self.prevNumber = Int(number)
            }
        }
        
    }
}
//MARK: -  All Clear
extension CalculatorViewModel {
    private func didSelectAllClear() {
        self.currentNumber = .firstNumber
        self.firstNumber = nil
        self.secondNumber = nil
        self.operation = nil
        self.prevNumber = nil
        self.prevOperaion = nil
    }
}
//MARK: -  plus / minus
extension CalculatorViewModel {
    private func didSelectPlusMinus() {
        if self.currentNumber == .firstNumber, var number = self.firstNumber  {
            number.negate()
            self.firstNumber = number
            self.prevNumber = number
        }else if self.currentNumber == .secondNumber, var number = self.secondNumber {
            number.negate()
            self.secondNumber = number
             self.prevNumber = number
        }
    }
}
//MARK: -  Persentage
extension CalculatorViewModel {
    private func didSelectPersentage() {
        if self.currentNumber == .firstNumber, var number = self.firstNumber  {
            number /= 100
            self.firstNumber = number
            self.prevNumber = number
        }else if self.currentNumber == .secondNumber, var number = self.secondNumber {
            number /= 100
            self.secondNumber = number
            self.prevNumber = number
        }
    }
}
//MARK: - Equals & Arithmetic Operaion
extension CalculatorViewModel {
    private func didSelectOperion(with operaion: CalculatorOperaion) {
        if self.currentNumber == .firstNumber {
            self.operation = operaion
            self.currentNumber = .secondNumber
        }else if self.currentNumber == .secondNumber { // when the result apears after clicking the operaion 3 times.
            if let prevOperaion = self.operation,
            let firstNumber = self.firstNumber,
               let secondNumber = self.secondNumber {
                let result = self.getOperaionResult(prevOperaion, firstNumber, secondNumber)
                self.secondNumber = nil // reset the second number , cuz we set the current number to the second number and then we are gonna set the first number to the result
                self.firstNumber = result
                self.currentNumber = .secondNumber
                self.operation = operaion
            }  else {  // if we are on the second number but it's nil, so that means we are trying to change the operaion
                self.operation = operaion
            }
        }
    }
    
    private func didSelectEqualsButton() {
        if let operation = self.operation,
           let firstNumber = self.firstNumber,
           let secondNumber = self.secondNumber {
            // Equals is pressed normally after first number -> operaon -> second number 6 x 6 =
            let result = self.getOperaionResult(operation, firstNumber, secondNumber)
            self.secondNumber = nil
            self.prevOperaion = operation
            self.operation = nil
            self.firstNumber = result
            self.currentNumber = .firstNumber
            // when we click "=" multiple times
        } else if let prevOperaion = self.prevOperaion,
                  let firstNumber = self.firstNumber,
                  let prev = self.prevNumber
        {
            // This will update the calculator based on previoulsy selected number and operaion
            let result = self.getOperaionResult(prevOperaion, firstNumber, prev)
            self.firstNumber = result
        }
    }


    //MARK: - HELPER
    private func getOperaionResult(_ operaion: CalculatorOperaion, _ firstNumber: Int, _ secondNumber: Int) -> Int {
        switch operaion {
            
        case .add:
            return firstNumber + secondNumber
        case .subtract:
            return firstNumber - secondNumber
        case .multiply:
            return firstNumber * secondNumber
        case .divide:
            return firstNumber / secondNumber
        }
    }
}
