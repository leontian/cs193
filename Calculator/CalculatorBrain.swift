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
    
    
    // here return value is a tuple, could be unnamed
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
                let operand1Evaluation = evaluate(remainingOps)
                if let operand1 = operand1Evaluation.result {
                    let operand2Evaluation = evaluate(remainingOps)
                    if let operand2 = operand2Evaluation.result {
                        return (operation(operand1, operand2), operand2Evaluation.remainingOps)
                    }
                }
            }
        }
        return (nil, ops)
    }
    
    private func evaluate() -> Double? {
        let (result, remainingOps) = evaluate(opStack)
        return result
    }
    
    func pushOperand(operand: Double) {
 
    }
    
    func performOperation(symbol: String) {
        if let operation = knownOps[symbol] {
            opStack.append(operation)
        }
    }
    
    
}