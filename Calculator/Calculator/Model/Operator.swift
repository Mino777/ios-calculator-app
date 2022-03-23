//
//  Operator.swift
//  Calculator
//
//  Created by 조민호 on 2022/03/17.
//

import Foundation

enum Operator: Character, CaseIterable, CalculateItem {
    case add = "+"
    case substract = "−"
    case divide = "/"
    case multiply = "*"
}

extension Operator {
    func calculate(lhs: Double, rhs: Double) throws -> Double {
        switch self {
        case .add:
            return add(lhs: lhs, rhs: rhs)
        case .substract:
            return substract(lhs: lhs, rhs: rhs)
        case .divide:
            return try divide(lhs: lhs, rhs: rhs)
        case .multiply:
            return multiply(lhs: lhs, rhs: rhs)
        }
    }
    
    private func add(lhs: Double, rhs: Double) -> Double {
        return lhs + rhs
    }
    
    private func substract(lhs: Double, rhs: Double) -> Double {
        return lhs - rhs
    }
    
    private func divide(lhs: Double, rhs: Double) throws -> Double {
        if rhs == .zero {
            throw CalculatorError.dividedByZero
        }
        
        return lhs / rhs
    }

    private func multiply(lhs: Double, rhs: Double) -> Double {
        return lhs * rhs
    }
}
