//
//  Operators.swift
//  CalculatorImg
//
//  Created by Andrii Kyrychenko on 11/06/2022.
//

import Foundation

enum Operator: String {
    case cAdd = "+"
    case cSubtract = "-"
    case cTimes = "*"
    case cDivid = "/"
    case nothing = ""
}

enum CalculationState: String {
    case enteringNum = "enteringNum"
    case newNumStarted = "newNumStarted"
}
