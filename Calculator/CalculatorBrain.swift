//
//  CalculatorBrain.swift
//  Calculator
//
//  Created by andy on 2017-09-25.
//  Copyright © 2017 andy. All rights reserved.
//

import Foundation

// classes live in heap
// structs are pass by copy

// structs gets their own initialiser
struct CalculatorBrain{
    
    private var accumulator: Double?
    
    private enum Operation {
        case constant(Double)
        case unaryOperation((Double) -> Double)
        case binaryOperation((Double, Double) -> Double)
        case equals
    }
    
    private var operations: Dictionary<String, Operation> =
    [
        "π": Operation.constant(Double.pi),
        "e": Operation.constant(M_E),
        "√": Operation.unaryOperation(sqrt),
        "cos" : Operation.unaryOperation(cos),
        "±": Operation.unaryOperation({-$0}),
        "x" : Operation.binaryOperation({$0*$1}),
        "+" : Operation.binaryOperation({$0 + $1}),
        "-" : Operation.binaryOperation({$0 - $1}),
        "÷" : Operation.binaryOperation({$0/$1}),
        "=" : Operation.equals,
        "C" : Operation.constant(0)
    ]
    

    
    mutating func performOperation(_ symbol: String)
    {
        if let op = operations[symbol] {
            switch op {
            case .constant(let value):
                accumulator = value
            case .unaryOperation(let function):
                if accumulator != nil
                {
                    accumulator = function(accumulator!)
                }
            case .binaryOperation(let function):
                if accumulator != nil{
                    pendingBinaryOperation = PendingBinaryOperation(function: function, firstOperand: accumulator!)
                    accumulator = nil
                }
            case .equals:
                performPendingBinaryOperation()
            }
        }
    }
    
    private mutating func performPendingBinaryOperation()
    {
        if pendingBinaryOperation != nil && accumulator != nil {
            accumulator = pendingBinaryOperation!.perform(with: accumulator!)
            pendingBinaryOperation = nil
        }
    }
    
    private var pendingBinaryOperation:PendingBinaryOperation?
    
    private struct PendingBinaryOperation {
        let function: (Double, Double) -> Double
        let firstOperand: Double
        
        func perform(with secondOperand: Double) -> Double{
            return function(firstOperand , secondOperand)
        }
    }
    
    mutating func setOperand(_ operand: Double)
    {
        accumulator = operand
    }
    
    var result: Double?
    {
        get {
            return accumulator
        }
        set {
            
        }
    }
}
