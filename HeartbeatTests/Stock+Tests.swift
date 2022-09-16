//
//  Stock+Tests.swift
//  HeartbeatTests
//
//  Created by Joshua Grant on 9/15/22.
//

import XCTest
@testable import Heartbeat

final class Stock_Tests: XCTestCase
{
    func test_stock_init()
    {
        let stock = Stock<Double>(
            current: 0,
            ideal: 50,
            min: 0,
            max: 100,
            unit: UnitArea.acres)
        XCTAssertNotNil(stock)
    }
    
    func test_stock_imbalance()
    {
        let stock = Stock<Double>(
            current: 25,
            ideal: 75,
            min: 0,
            max: 100,
            unit: UnitArea.acres)
        XCTAssertEqual(stock.imbalance, 0.33, accuracy: 0.01)
    }
}
