//
//  FormulaTests.swift
//  CalculatorItemQueueTests
//
//  Created by 조민호 on 2022/03/18.
//

import XCTest

class FormulaTests: XCTestCase {
    var sut: Formula!
    
    override func setUpWithError() throws {
        try super.setUpWithError()
        sut = Formula(operands: CalculatorItemQueue<Double>(), operators: CalculatorItemQueue<Operator>())
    }

    override func tearDownWithError() throws {
        try super.tearDownWithError()
        sut = nil
    }
    
    func test_operand가없는경우result를호출할때_예상되는에러를반환해야한다() {
        // given
        // when
        // then
        let expected: QueueError = .notFoundElement
        XCTAssertThrowsError(try sut.result()) { error in
            XCTAssertEqual(error as? QueueError, expected)
        }
    }
    
    func test_operator가없는경우result를호출할때_예상되는에러를반환해야한다() {
        // given
        var mockOperandQueue = CalculatorItemQueue<Double>()
        
        [-1, 2, 3, 4, 5].forEach {
            mockOperandQueue.enqueue($0)
        }

        // when
        // then
        let expected: QueueError = .notFoundElement
        XCTAssertThrowsError(try sut.result()) { error in
            XCTAssertEqual(error as? QueueError, expected)
        }
    }
}