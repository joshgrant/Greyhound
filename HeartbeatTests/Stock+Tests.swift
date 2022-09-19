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
    func test_stock1D_init()
    {
        let stock = Stock(
            name: "stock",
            current: 0,
            ideal: { 50 },
            min: 0,
            max: 100,
            unit: UnitArea.acres)
        XCTAssertNotNil(stock)
    }
    
    func test_stock_balance()
    {
        let stock = Stock(
            name: "stock",
            current: 25,
            ideal: { 75 },
            min: 0,
            max: 100,
            unit: UnitArea.acres)
        XCTAssertEqual(stock.balance, 0.33, accuracy: 0.01)
    }
    
    func test_stock_balanceZero()
    {
        let stock = Stock(
            name: "stock",
            current: 0,
            ideal: { 100 },
            min: 0,
            max: 100,
            unit: UnitArea.acres)
        XCTAssertEqual(stock.balance, 0)
    }
    
    func test_stock_balanceOne()
    {
        let stock = Stock(
            name: "stock",
            current: 100,
            ideal: { 100 },
            min: 0,
            max: 100,
            unit: UnitArea.acres)
        XCTAssertEqual(stock.balance, 1)
    }
}
