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
    func test_stock_unitCanBeNil()
    {
        let stock = Stock(
            unit: nil,
            current: { 0 },
            maximum: { 100 },
            ideal: { 50 })
        XCTAssertEqual(stock.unit, nil)
    }
    
    func test_delta_noDelta()
    {
        let stock = Stock(
            unit: UnitEnergy.calories,
            current: { 23 },
            maximum: { 200 },
            ideal: { 23 })
        
        XCTAssertEqual(stock.delta, 0)
    }
    
    func test_delta_negativeDelta()
    {
        let stock = Stock(
            unit: UnitEnergy.calories,
            current: { 17 },
            maximum: { 100 },
            ideal: { 40 })
        
        XCTAssertEqual(stock.delta, -23)
    }
    
    func test_delta_positiveDelta()
    {
        let stock = Stock(
            unit: UnitEnergy.calories,
            current: { 91 },
            maximum: { 1000 },
            ideal: { 12 })
        
        XCTAssertEqual(stock.delta, 79)
    }
    
    func test_balance_zeroDelta()
    {
        let stock = Stock(
            unit: UnitEnergy.calories,
            current: { 40 },
            maximum: { 100 },
            ideal: { 40 })
        
        XCTAssertEqual(stock.balance, 1)
    }
    
    func test_balance_maximumDelta()
    {
        let stock = Stock(
            unit: UnitEnergy.calories,
            current: { 0 },
            maximum: { 100 },
            ideal: { 100 })
        
        XCTAssertEqual(stock.balance, 0)
    }
    
    func test_balance_thirdDelta()
    {
        let stock = Stock(
            unit: UnitEnergy.calories,
            current: { 40 },
            maximum: { 120 },
            ideal: { 80 })
        
        XCTAssertEqual(stock.balance, 0.666, accuracy: 0.001)
    }
    
    func test_maximumTransferAmount_zero()
    {
        let stock = Stock(
            unit: UnitEnergy.calories,
            current: { 0 },
            maximum: { 100 },
            ideal: { 100 })
        
        XCTAssertEqual(stock.maximumTransferAmount, 0)
    }
    
    func test_maximumTransferAmount()
    {
        let stock = Stock(
            unit: UnitEnergy.calories,
            current: { 8 },
            maximum: { 100 },
            ideal: { 100 })
        
        XCTAssertEqual(stock.maximumTransferAmount, 8)
    }
    
    func test_maximumTransferAmount_max()
    {
        let stock = Stock(
            unit: UnitEnergy.calories,
            current: { 100 },
            maximum: { 100 },
            ideal: { 100 })
        
        XCTAssertEqual(stock.maximumTransferAmount, 100)
    }
    
    func test_maximumReceiveAmount_zero()
    {
        let stock = Stock(
            unit: UnitEnergy.calories,
            current: { 100 },
            maximum: { 100 },
            ideal: { 100 })
        XCTAssertEqual(stock.maximumReceiveAmount, 0)
    }
    
    func test_maximumReceiveAmount()
    {
        let stock = Stock(
            unit: UnitEnergy.calories,
            current: { 87 },
            maximum: { 100 },
            ideal: { 100 })
        XCTAssertEqual(stock.maximumReceiveAmount, 13)
    }
    
    func test_maximumReceiveAmount_max()
    {
        let stock = Stock(
            unit: UnitEnergy.calories,
            current: { 0 },
            maximum: { 100 },
            ideal: { 100 })
        XCTAssertEqual(stock.maximumReceiveAmount, 100)
    }
}
