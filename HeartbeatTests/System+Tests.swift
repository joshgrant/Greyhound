//
//  System+Tests.swift
//  HeartbeatTests
//
//  Created by Joshua Grant on 9/15/22.
//

import XCTest
@testable import Heartbeat

final class System_Tests: XCTestCase
{
    func test_system_init()
    {
        let system = System(stocks: [], flows: [])
        XCTAssertNotNil(system)
    }
    
    func test_system_leastBalancedStock()
    {
        let system = System(stocks: [
            .init(current: 50, ideal: 100, min: 0, max: 100, unit: UnitArea.acres),
            .init(current: 75, ideal: 100, min: 0, max: 100, unit: UnitArea.acres)
        ], flows: [])
        let leastBalanced = system.leastBalanced
        XCTAssertEqual(leastBalanced?.current, 50)
    }
    
    func test_system_nextFlow()
    {
        let stockA = Stock(
            current: 0,
            ideal: 100,
            min: 0,
            max: 100)
        let stockB = Stock(
            current: 4,
            ideal: 0,
            min: 0,
            max: 100)
        
        let flowA = Flow(
            from: stockA,
            to: stockB,
            amount: 4,
            duration: 1)
        let flowB = Flow(
            from: stockB,
            to: stockA,
            amount: 4,
            duration: 1)
        
        let system = System(
            stocks: [stockA, stockB],
            flows: [flowA, flowB])
        
        let nextFlow = system.nextFlow
        XCTAssertEqual(nextFlow, flowB)
    }
    
    func test_system_balance_allStocksInBalance()
    {
        let system = System(
            stocks: [
                .init(current: 1, ideal: 1, min: 0, max: 1),
                .init(current: 1, ideal: 1, min: 0, max: 1)
            ],
            flows: [])
        let balance = system.balance
        XCTAssertEqual(balance, 1)
    }
    
    func test_system_balance_halfStocksInBalance()
    {
        let system = System(
            stocks: [
                .init(current: 1, ideal: 1, min: 0, max: 1),
                .init(current: 0, ideal: 1, min: 0, max: 1)
            ],
            flows: [])
        let balance = system.balance
        XCTAssertEqual(balance, 0.5)
    }
    
    func test_system_balance_noStocksInBalance()
    {
        let system = System(
            stocks: [
                .init(current: 0, ideal: 1, min: 0, max: 1),
                .init(current: 0, ideal: 1, min: 0, max: 1)
            ],
            flows: [])
        let balance = system.balance
        XCTAssertEqual(balance, 0)
    }
}
