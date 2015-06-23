//
//  CalculatorBrain.swift
//  Calculator
//
//  Created by Liang Tian on 6/23/15.
//  Copyright (c) 2015 Liang Tian. All rights reserved.
//

import Foundation

class CalculatorBrain
{
    private enum Op: Printable {
        case Operand(Double)
        case UnaryOperation(String, Double -> Double)
        case BinaryOperation(String, (Double, Double) -> Double)
        
        var description: String {
            get {
                switch self {
                case .Operand(let operand):
                    return "\(operand)"
                case .UnaryOperation(let symbol, _):
                    return symbol
                case .BinaryOperation(let symbol, _):
                    return symbol
                }
            }
        }
        
    }
    
    private var opStack = [Op]()
    
    private var knownOps = [String: Op]()
    
    init() {
        func learnOps(op: Op) {
            knownOps[op.description] = op
        }
        learnOps(Op.UnaryOperation("√", sqrt))
        learnOps(Op.BinaryOperation("÷", /))
        learnOps(Op.BinaryOperation("+", +))
        learnOps(Op.BinaryOperation("×", *))
        learnOps(Op.BinaryOperation("−", -))
        
    }
    
    private func evaluate(ops: [Op]) -> (result: Double?, remainingOps: [Op]) {
        if !ops.isEmpty {
            var remainingOps = ops
            let op = remainingOps.removeLast()
            switch op {
            case .Operand(let operand):
                return (operand, remainingOps)
            case .UnaryOperation(_, let operation):
                let operandEvaluation = evaluate(remainingOps)
                if let operand = operandEvaluation.result {
                    return (operation(operand), operandEvaluation.remainingOps)
                }
            case .BinaryOperation(_, let operation):
                return (0, remainingOps); //TODO
            }
        }
        return (nil, ops)
    }
    
    private func evaluate() {
        
    }
    
    func pushOperand(operand: Double) {
 
    }
    
    func performOperation(symbol: String) {
        if let operation = knownOps[symbol] {
            opStack.append(operation)
        }
    }
    
    
}