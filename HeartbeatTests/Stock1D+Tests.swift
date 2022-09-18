//
//  Stock1D+Tests.swift
//  HeartbeatTests
//
//  Created by Joshua Grant on 9/15/22.
//

import XCTest
@testable import Heartbeat

final class Stock1D_Tests: XCTestCase
{
    func test_stock1D_init()
    {
        let stock = Stock1D(
            current: 0,
            ideal: 50,
            min: 0,
            max: 100,
            unit: UnitArea.acres)
        XCTAssertNotNil(stock)
    }
    
    func test_stock1D_balance()
    {
        let stock = Stock1D(
            current: 25,
            ideal: 75,
            min: 0,
            max: 100,
            unit: UnitArea.acres)
        XCTAssertEqual(stock.balance, 0.33, accuracy: 0.01)
    }
    
    func test_stock1D_balanceZero()
    {
        let stock = Stock1D(
            current: 0,
            ideal: 100,
            min: 0,
            max: 100,
            unit: UnitArea.acres)
        XCTAssertEqual(stock.balance, 0)
    }
    
    func test_stock1D_balanceOne()
    {
        let stock = Stock1D(
            current: 100,
            ideal: 100,
            min: 0,
            max: 100,
            unit: UnitArea.acres)
        XCTAssertEqual(stock.balance, 1)
    }
}
