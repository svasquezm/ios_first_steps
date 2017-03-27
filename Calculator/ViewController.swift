//
//  ViewController.swift
//  Calculator
//
//  Created by sebastian vasquez on 3/26/17.
//  Copyright © 2017 sebastian vasquez. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    var inMiddleOfTyping = false
    @IBOutlet private weak var resultLabel: UILabel!
    
    // Properties
    private var brain = CalculatorBrain()
    private var displayValue: Double {
        get {
            return Double(resultLabel.text!)!
        }
        
        set {
            resultLabel.text = String(newValue)
        }
    }
    
    /**
     * Actions
     */
    @IBAction private func numberClick(_ sender: UIButton) {
        if(inMiddleOfTyping){
            resultLabel.text = resultLabel.text! + sender.currentTitle!
        } else {
            resultLabel.text = sender.currentTitle
            inMiddleOfTyping = true
        }
    }
    
    @IBAction private func performOperation(_ sender: UIButton) {
        if inMiddleOfTyping {
            brain.setOperand(operand: displayValue)
            inMiddleOfTyping = false
        }
        if let symbol = sender.currentTitle {
            brain.performOperation(symbol: symbol)
        }
        
        displayValue = brain.result
    }
}

