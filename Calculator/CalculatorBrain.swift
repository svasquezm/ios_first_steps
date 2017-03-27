//
//  CalculatorBrain.swift
//  Calculator
//
//  Created by sebastian vasquez on 3/26/17.
//  Copyright © 2017 sebastian vasquez. All rights reserved.
//

import Foundation

class CalculatorBrain {
    
    var accumulator = 0.0
    enum Operation {
        case Constant(Double)
        case UnaryOperation((Double) -> Double)
        case BinaryOperation((Double, Double) -> Double)
        case Equals
    }
    
    var operations: Dictionary<String, Operation> = [
        "π" : Operation.Constant(M_PI),
        "e" : Operation.Constant(M_E),
        "sqrt()": Operation.UnaryOperation(sqrt),
        "*": Operation.BinaryOperation({ $0 * $1 }),
        "/": Operation.BinaryOperation({ $0 / $1 }),
        "+": Operation.BinaryOperation({ $0 + $1 }),
        "-": Operation.BinaryOperation({ $0 - $1 }),
        "=": Operation.Equals
    ]
    
    func setOperand(operand: Double){
        accumulator = operand
    }
    
    var pendingOperationInfo: PendingBinaryOperationInfo?
    func performOperation(symbol: String){
        if let operation = operations[symbol] {
            switch operation {
            case .Constant(let value): accumulator = value
            case .UnaryOperation(let function): accumulator = function(accumulator)
            case .BinaryOperation(let function):
                executePendingOperations()
                pendingOperationInfo = PendingBinaryOperationInfo(binaryFunction: function, firstOperand: accumulator)
            case .Equals:
                executePendingOperations()
            }
        }
    }
    
    func executePendingOperations() {
        if pendingOperationInfo != nil {
            accumulator = pendingOperationInfo!.binaryFunction(pendingOperationInfo!.firstOperand, accumulator)
            pendingOperationInfo = nil
        }
    }
    
    struct PendingBinaryOperationInfo {
        var binaryFunction: (Double, Double) -> Double
        var firstOperand: Double
    }
    
    var result: Double {
        get {
            return accumulator
        }
    }
}
