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
    
    }
    
    var operandStack = [Double]()
    
    @IBAction func enter() {
        usrIsInTheMiddleOfTypingADigit = false
        operandStack.append(displayValue)
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
            display.text = "\(newValue)"
        }
    }
}

