//
//  ExpressionParserTests.swift
//  CalculatorItemQueueTests
//
//  Created by 조민호 on 2022/03/18.
//

import XCTest

class ExpressionParserTests: XCTestCase {
    var mockExpression = "1 + 2 - -3 / 4 * -5"

    func test_parse를호출할때_operands의카운트값이예상값과같아야한다() {
        // given
        // when
        let formula = ExpressionParser.parse(from: mockExpression)
        
        // then
        let result = formula._operandsCount
        let expected = 5
        XCTAssertEqual(result, expected)
    }
    
    func test_parse를호출할때_operators의카운트값이예상값과같아야한다() {
        // given
        // when
        let formula = ExpressionParser.parse(from: mockExpression)
        
        // then
        let result = formula._operatorsCount
        let expected = 4
        XCTAssertEqual(result, expected)
    }
    
    func test_parse를호출할때_반환된표현식의결과값이예상값과같아야한다() {
        // given
        mockExpression = "1 + 2 - -3 / -4 * 5"
        
        // when
        var formula = ExpressionParser.parse(from: mockExpression)
        
        // then
        var result = (1.0 + 2.0 - (-3.0)) / (-4.0) * 5.0
        XCTAssertEqual(Double(result), try formula.result())
        
        // given
        mockExpression = "-1 - -2 - -3 / -4 * 5"
        
        // when
        formula = ExpressionParser.parse(from: mockExpression)
        
        // then
        result = (-1.0 - (-2.0) - (-3.0)) / (-4.0) * 5.0
        XCTAssertEqual(Double(result), try formula.result())
        
        // given
        mockExpression = "-11.4 - -2 - -3 / -4 * 5"
        
        // when
        formula = ExpressionParser.parse(from: mockExpression)
        
        // then
        result = (-11.4 - (-2.0) - (-3.0)) / (-4.0) * 5.0
        XCTAssertEqual(Double(result), try formula.result())
    }
    
    func test_parse를호출할때_반환된표현식이_0으로divide되는경우예상된에러를반환해야한다() {
        // given
        mockExpression = "1 + 2 - 3 / 0 * -5"
        
        // when
        var formula = ExpressionParser.parse(from: mockExpression)
        
        // then
        let expected: CalculatorError = .dividedByZero
        XCTAssertThrowsError(try formula.result()) { error in
            XCTAssertEqual(error as? CalculatorError, expected)
        }
    }
    
    func test_parse를호출할때_반환된표현식에_연산자가없는경우_예상되는에러를반환해야한다() {
        // given
        mockExpression = "1230-5"
        
        // when
        var formula = ExpressionParser.parse(from: mockExpression)
        
        // then
        let expected: QueueError = .notFoundElement
        XCTAssertThrowsError(try formula.result()) { error in
            XCTAssertEqual(error as? QueueError, expected)
        }
    }
    
    func test_parse를호출할때_반환된표현식에_피연산자가없는경우_예상되는에러를반환해야한다() {
        // given
        mockExpression = "+-/*"
        
        // when
        var formula = ExpressionParser.parse(from: mockExpression)
        
        // then
        let expected: QueueError = .notFoundElement
        XCTAssertThrowsError(try formula.result()) { error in
            XCTAssertEqual(error as? QueueError, expected)
        }
    }
    
    func test_parse를호출할때_반환된표현식에_숫자가너무큰경우() {
        // given
        mockExpression = "999999999 + 999999999 - 999999999 / 999999999 * 999999999"
        
        // when
        var formula = ExpressionParser.parse(from: mockExpression)
        
        // then
        let result = (999999999.0+999999999.0-999999999.0)/999999999.0*999999999.0
        XCTAssertEqual(Double(result), try formula.result())
    }
}
