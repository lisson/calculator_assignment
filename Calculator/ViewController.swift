//
//  ViewController.swift
//  Calculator
//
//  Created by andy on 2017-09-24.
//  Copyright © 2017 andy. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    var UserIsTyping: Bool = false;
    
    var displayValue: Double {
        get {
            return Double(display.text!)!
        }
        set {
            display.text = String(newValue)
        }
    }
    
    @IBAction func touchDigit(_ sender: UIButton)
    {
        let digit = sender.currentTitle!
        if UserIsTyping
        {
            let textCurrentlyInDisplay = display.text!
            switch digit
            {
                case ".":
                if display.text?.contains(".") == false
                {
                    display.text = textCurrentlyInDisplay + digit
                }
            default:
                display.text = textCurrentlyInDisplay + digit
            }
        }
        else
        {
            if digit == "."
            {
                display.text = "0."
            }
            else
            {
                display.text = digit
            }
            UserIsTyping = true
        }
    }
    
    private var brain: CalculatorBrain = CalculatorBrain()
    
    @IBAction func performOperation(_ sender: UIButton)
    {
        if UserIsTyping {
            brain.setOperand(displayValue)
            UserIsTyping = false
        }
        UserIsTyping = false
        let op = sender.currentTitle!
        brain.performOperation(op)
        if let result = brain.result{
            displayValue = result
            sequence.text = brain.description
        }
    }

    @IBOutlet weak var sequence: UILabel!
    @IBOutlet weak var display: UILabel!
}

