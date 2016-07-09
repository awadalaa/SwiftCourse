//
//  CalculatorBrain.swift
//  Calculator
//
//  Created by Alaa Awad on 7/9/16.
//  Copyright © 2016 Alaa Awad. All rights reserved.
//

import Foundation

func multiply(op1:Double, op2:Double) -> Double
{
    return op1 * op2
}

class CalculatorBrain
{
    private var accumulator = 0.0
    private var internalProgram = [AnyObject]()
    private var operations: Dictionary<String, Operation> = [
        "π": Operation.Constant(M_PI),
        "e": Operation.Constant(M_E),
        "√": Operation.UnaryOperation(sqrt),
        "cos": Operation.UnaryOperation(cos),
        "±": Operation.UnaryOperation({ -$0 }),
        "×": Operation.BinaryOperation({ $0 * $1 }),
        "÷": Operation.BinaryOperation({ $0 / $1 }),
        "+": Operation.BinaryOperation({ $0 + $1 }),
        "−": Operation.BinaryOperation({ $0 - $1 }),
        "=": Operation.Equals
    ]
    
    enum Operation {
        case Constant(Double)
        case UnaryOperation((Double) -> Double)
        case BinaryOperation((Double,Double) -> Double)
        case Equals
    }
    
    private var pending: PendingBinaryOperationInfo?
    struct PendingBinaryOperationInfo {
        var binaryFunction: (Double, Double) -> Double
        var firstOperand: Double
    }
    
    func setOperand(operand: Double) {
        accumulator = operand
        internalProgram.append(operand)
    }
    
    func performOperation(symbol: String) {
        if let operation = operations[symbol] {
            switch operation {
            case .Constant(let value):
                accumulator = value
            case .UnaryOperation(let fn):
                accumulator = fn(accumulator)
            case .BinaryOperation(let fn):
                executePendingBinaryOperation()
                pending = PendingBinaryOperationInfo(binaryFunction: fn, firstOperand: accumulator)
            case .Equals:
                executePendingBinaryOperation()
            }
            
        }
    }
    
    private func executePendingBinaryOperation() {
        if pending != nil {
            accumulator = pending!.binaryFunction(pending!.firstOperand, accumulator)
            pending = nil
        }
    }spo
    
    typealias PropertyList = AnyObject
    var program: PropertyList {
        get {
            return internalProgram
        }
        set {
            clear()
            if let arrayOfOps = newValue as? [AnyObject] {
                for op in arrayOfOps {
                    if let operand = op as? Double {
                        setOperand(operand)
                    } else if let operand = op as? String {
                        performOperation(operand)
                    }
                }
            }
        }
    }
    
    func clear() {
        accumulator = 0.0
        pending = nil
        internalProgram.removeAll()
    }
    
    var result: Double {
        get {
            return accumulator
        }
        
    }
}