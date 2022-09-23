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
    func test_balance_noStocks()
    {
        let system = System()
        XCTAssertEqual(system.balance, 1)
    }
    
    func test_balance_oneStock()
    {
        let system = System()
        system.stocks = [
            .init(
                unit: .acres,
                current: { 5 },
                maximum: { 100 },
                ideal: { 20 })
        ]
        
        XCTAssertEqual(system.balance, 0.85)
    }
    
    func test_balance_twoStocks()
    {
        let system = System()
        system.stocks = [
            .init(
                unit: .acres,
                current: { 5 },
                maximum: { 100 },
                ideal: { 20 }),
            .init(
                unit: .acres,
                current: { 20 },
                maximum: { 100 },
                ideal: { 50 })
        ]
        XCTAssertEqual(system.balance, 0.775)
    }
    
    func test_convertToStock()
    {
        let system = System()
        system.stocks = [
            .init(
                unit: .gallons,
                current: { 5 },
                maximum: { 100 },
                ideal: { 20 }),
            .init(
                unit: .acres,
                current: { 20 },
                maximum: { 100 },
                ideal: { 50 })
        ]
        let stock = system.convertToStock()
        XCTAssertEqual(stock.current, 25)
        XCTAssertEqual(stock.maximum, 200)
        XCTAssertEqual(stock.ideal, 70)
        XCTAssertEqual(stock.balance, 0.775)
    }
}
