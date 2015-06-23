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
    
    var brain = CalculatorBrain()
    
    @IBAction func operate(sender: UIButton) {
        if usrIsInTheMiddleOfTypingADigit {
            enter()
        }
        if let operation = sender.currentTitle {
            if let result = brain.performOperation(operation) {
                displayValue = result
            } else {
                displayValue = 0
                //TODO
            }
            
        }
    }
    
    
    @IBAction func enter() {
        usrIsInTheMiddleOfTypingADigit = false
        if let result = brain.pushOperand(displayValue) {
            displayValue = result
        } else {
            displayValue = 0
            //TODO
        }
        
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

