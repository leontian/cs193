//
//  ViewController.swift
//  Calculator
//
//  Created by Liang Tian on 6/22/15.
//  Copyright (c) 2015 Liang Tian. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var display: UILabel!
    var usrIsInTheMiddleOfTypingADigit = false
    
    @IBAction func operate(sender: UIButton) {
        if usrIsInTheMiddleOfTypingADigit {
            enter()
        }
        switch(sender.currentTitle!) {
        case "+":
            performOperation { $0 + $1 }
        case "÷":
            performOperation { $1 / $0 }
        case "✕":
            performOperation(*)
        case "−":
            performOperation { $1 / $0 }
        case "√":
            performOperation(sqrt)
        default:
            break
        }
    
    }
    
    private func performOperation(operation: (Double, Double) -> Double) {
        if operandStack.count >= 2 {
            displayValue = operation(operandStack.removeLast(), operandStack.removeLast())
            enter()
        }
    }
    
    private func performOperation(operation: Double -> Double) {
        if operandStack.count >= 1 {
            displayValue = operation(operandStack.removeLast())
            enter()
        }
    }
    
    var operandStack = [Double]()
    //var operandStackTest: Array<Double> = Array<Double>()
    
    
    @IBAction func enter() {
        usrIsInTheMiddleOfTypingADigit = false
        operandStack.append(displayValue)
        println("operandStack = \(operandStack)")
    }
    
    @IBAction func appendDigit(sender: UIButton) {
        let digit = sender.currentTitle!
        if usrIsInTheMiddleOfTypingADigit {
            display.text = display.text! + digit
        }
        else {
            display.text = digit
            usrIsInTheMiddleOfTypingADigit = true
        }
        //println("digit = \(digit)")
    }
    
    var displayValue: Double {
        get {
            return NSNumberFormatter().numberFromString(display.text!)!.doubleValue
        }
        set {
            display.text = "\(newValue)" // newValue is automatically set to the value after "="
        }
    }
}

