//
//  ViewController.swift
//  Calculator iOS
//
//  Created by Sebastian Morado on 5/25/21
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var displayLabel: UILabel!
    
    private var calculatorLogic = CalculatorLogic()
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    @IBAction func calcButtonPressed(_ sender: UIButton) {
        let output = calculatorLogic.calculate(operation: sender.currentTitle!, displayValue: displayLabel.text!)
        displayLabel.text = output
    }
    
    @IBAction func numButtonPressed(_ sender: UIButton) {
        let output = calculatorLogic.changeNumber(input: sender.currentTitle!, displayValue: displayLabel.text!)
        displayLabel.text = output
    }
    
}

