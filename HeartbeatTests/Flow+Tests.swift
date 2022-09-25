//
//  Flow+Tests.swift
//  HeartbeatTests
//
//  Created by Joshua Grant on 9/15/22.
//

import XCTest
@testable import Heartbeat

final class Flow_Tests: XCTestCase
{
    func test_update_stockA_lowPressure()
    {
        let stockA = Stock(
            current: Measurement(value: 0, unit: .meters),
            maximum: Measurement(value: 10, unit: .meters),
            ideal: Measurement(value: 10, unit: .meters))
        let stockB = Stock(
            current: Measurement(value: 10, unit: .meters),
            maximum: Measurement(value: 10, unit: .meters),
            ideal: Measurement(value: 0, unit: .meters))
        
        let flow = Flow(
            limit: .init(value: 3, unit: .meters),
            stockA: stockA,
            stockB: stockB)
        
        flow.update(0)
        flow.update(1)
        
        XCTAssertEqual(stockA.current.value, 3)
        XCTAssertEqual(stockB.current.value, 7)
        
        flow.update(2)
        
        XCTAssertEqual(stockA.current.value, 5)
        XCTAssertEqual(stockA.current.value, 4)
        
        flow.update(3)
        
        XCTAssertEqual(stockA.current.value, 9)
        XCTAssertEqual(stockA.current.value, 1)
        
        flow.update(4)
        
        XCTAssertEqual(stockA.current.value, 10)
        XCTAssertEqual(stockA.current.value, 0)
        
        flow.update(5)
        
        XCTAssertEqual(stockA.current.value, 10)
        XCTAssertEqual(stockA.current.value, 0)

    }
    
    func test_update_stockA_highPressure()
    {
        
    }
    
    func test_update_stockA_equalPressure()
    {
        
    }
    
    func test_update_stockA_noMaximum()
    {
        
    }
    
    func test_update_stockB_noMaximum()
    {
        
    }
}
