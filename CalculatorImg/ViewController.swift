//
//  ViewController.swift
//  CalculatorImg
//
//  Created by Andrii Kyrychenko on 10/06/2022.
//

import UIKit

class ViewController: UIViewController {
    
    private var currentOperator: Operator = Operator.nothing
    private var calcState = CalculationState.newNumStarted
    
    private var firstValue: String = ""
    private var secondValue: String = ""

    @IBOutlet weak var resultLabel: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    @IBAction func numberClicked(_ sender: UIButton) {
        updatePressButton(tag: sender.tag)
        updateDisplay(number: String(sender.tag))
    }
    
    func updateDisplay(number: String) {
        guard var result = resultLabel.text else { return }
        if calcState == CalculationState.enteringNum {
            result = ""
            firstValue = ""
            calcState = CalculationState.newNumStarted
        }
        if result == "0" {
            result = number
        } else {
            result += number
        }
        resultLabel.text = result
    }
    
    @IBAction func operatorClicked(_ sender: UIButton) {
        updatePressButton(tag: sender.tag)
        switch sender.tag {
        case 10:
            cleanValues()
        case 12:
            pointAdd()
        case 13:
            operationResult(newOperator: Operator.cAdd)
        case 14:
            operationResult(newOperator: Operator.cSubtract)
        case 15:
            operationResult(newOperator: Operator.cTimes)
        case 16:
            operationResult(newOperator: Operator.cDivid)
        default:
            return
        }
    }
    
    private func operationResult(newOperator: Operator) {
        if firstValue == "" {
            firstValue = resultLabel.text ?? "0"
            currentOperator = newOperator
            resultLabel.text = "0"
        } else {
            secondValue = resultLabel.text ?? "0"
            let result = returnOperation()
            currentOperator = newOperator
            firstValue = result
            resultLabel.text = "0"
            secondValue = ""
        }
    }
    
    private func returnOperation() -> String {
        var result: Double = 0
        switch currentOperator {
        case .cAdd:
            result = Double(firstValue)! + Double(secondValue)!
        case .cSubtract:
            result = Double(firstValue)! - Double(secondValue)!
        case .cTimes:
            result = Double(firstValue)! * Double(secondValue)!
        case .cDivid:
            result = Double(firstValue)! / Double(secondValue)!
        case .nothing:
            return ""
        }
        return String(result)
    }
    
    private func cleanValues() {
        resultLabel.text = "0"
        firstValue = ""
        secondValue = ""
    }
    
    private func pointAdd() {
        guard let result = resultLabel.text else { return }
        if result.contains(".") {
            return
        } else {
            resultLabel.text = result + "."
        }
    }
    
    @IBAction func equalsClicked(_ sender: UIButton) {
        
        secondValue = resultLabel.text ?? "0"
        let result = returnOperation()
        resultLabel.text = result
        firstValue = result
        secondValue = ""
        calcState = CalculationState.enteringNum
    }

    func updatePressButton(tag: Int) {
        for i in 0...16 {
            if let button = self.view.viewWithTag(i) as? UIButton {
                button.backgroundColor = .clear
            }
        }
        
        if let button = self.view.viewWithTag(tag) as? UIButton {
            button.backgroundColor = .systemYellow
        }
    }
}

