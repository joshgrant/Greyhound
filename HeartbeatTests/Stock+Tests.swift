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
        XCTAssertEqual(stock.balance ?? -1, 0.33, accuracy: 0.01)
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
        XCTAssertEqual(stock.balance ?? -1, 0)
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
        XCTAssertEqual(stock.balance ?? -1, 1)
    }
    
    func test_stockBalanceBondedMatching()
    {
        let a = Stock(current: 90, ideal: { 100 }, min: 0, max: 100)
        let b = Stock(current: 110, ideal: { 100 }, min: 0, max: 100)
        
        let balanceA = a.balance(with: b)
        let balanceB = b.balance(with: a)
        
        XCTAssertEqual(balanceA, 1)
        XCTAssertEqual(balanceB, 1)
    }
    
    func test_stockBalanceBondedNotMatching()
    {
        let a = Stock(current: 10, ideal: { 100 }, min: 0, max: 100)
        let b = Stock(current: 110, ideal: { 100 }, min: 0, max: 100)
        
        let balanceA = a.balance(with: b)
        let balanceB = b.balance(with: a)
        
        XCTAssertNotNil(balanceA)
        XCTAssertNotNil(balanceB)
        
        XCTAssertEqual(balanceA!, 0.2, accuracy: 0.000001)
        XCTAssertEqual(balanceB!, 1)
    }
}
