//
//  CalculatorLogic.swift
//  Calculator iOS
//
//  Created by Sebastian Morado on 5/26/21
//

import Foundation

struct CalculatorLogic {
    private var isFinishedTyping : Bool = true
    private var isDecimalAlreadyPressed : Bool = false
    private var intermediateCalculation : (n1: Double, op: String, repeating_n2: Double?)?
    
    mutating func calculate(operation: String, displayValue: String) -> String {
        isFinishedTyping = true
        isDecimalAlreadyPressed = false
        
        guard var number = Double(displayValue) else {
            fatalError("displayLabel cannot be converted into Double")
        }
        
        switch operation {
        case "AC":
            intermediateCalculation = nil
            return "0"
        case "+/-":
            intermediateCalculation?.repeating_n2 = nil
            number *= -1
        case "%":
            intermediateCalculation?.repeating_n2 = nil
            number *= 0.01
        case "=":
            return performCalculation(n2: number)
        default:
            intermediateCalculation = (n1: number, op: operation, repeating_n2: nil)
        }
        
        if floor(number) == number && number < Double(Int.max) {
            return String(Int(number))
        }
        return String(number)
    }
    
    mutating func changeNumber(input: String, displayValue: String) -> String {
        if isFinishedTyping {
            isFinishedTyping = false
            if input == "." {
                isDecimalAlreadyPressed = true
                return "0."
            } else {
                return input
            }
        } else {
            if input == "." {
                if !isDecimalAlreadyPressed {
                    isDecimalAlreadyPressed = true
                    return displayValue + input
                }
            } else {
                return displayValue + input
            }
        }
        return displayValue
    }
    
    private mutating func performCalculation(n2: Double) -> String {
        if let n1 = intermediateCalculation?.n1, let operation = intermediateCalculation?.op {
            var solution : Double
            switch operation {
            case "+":
                solution = n1 + (intermediateCalculation?.repeating_n2 ?? n2)
            case "-":
                solution = n1 - (intermediateCalculation?.repeating_n2 ?? n2)
            case "×":
                solution = n1 * (intermediateCalculation?.repeating_n2 ?? n2)
            case "÷":
                solution = n1 / (intermediateCalculation?.repeating_n2 ?? n2)
            default:
                fatalError("Operation passed in does not match any of the cases")
            }
            
            intermediateCalculation?.n1 = solution
            if intermediateCalculation?.repeating_n2 == nil {
                intermediateCalculation?.repeating_n2 = n2
            }
            
            if floor(solution) == solution && solution < Double(Int.max) {
                return String(Int(solution))
            }
            return String(solution)
        } else {
            if floor(n2) == n2 && n2 < Double(Int.max) {
                return String(Int(n2))
            }
            return String(n2)
        }
    }
    
}
