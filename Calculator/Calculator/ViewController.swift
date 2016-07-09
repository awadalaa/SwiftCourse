//
//  ViewController.swift
//  Calculator
//
//  Created by Alaa Awad on 7/7/16.
//  Copyright © 2016 Alaa Awad. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    var userIsInTheMiddleOfTyping = false

    @IBOutlet weak var display: UILabel!

    @IBAction func touchDigit(sender: UIButton) {
        let digit = sender.currentTitle!

        if userIsInTheMiddleOfTyping {
            let textCurrentyInDisplay = display.text!
            display.text = textCurrentyInDisplay + digit
        } else {
            display.text = digit
        }
        userIsInTheMiddleOfTyping = true
    }
    

    @IBAction func performOperation(sender: UIButton) {
        userIsInTheMiddleOfTyping = false
        if let mathematicalSymbol = sender.currentTitle {
            if mathematicalSymbol == "π" {
                display.text = String(M_PI)
            }
        }
        
    }
}

