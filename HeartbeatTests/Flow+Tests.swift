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
    func test_flow_transferAmount_differingStockUnits()
    {
        let from = Stock(
            unit: .liters,
            current: { 3 },
            maximum: { 3 },
            ideal: { 0 })
        let to = Stock(
            unit: .gallons,
            current: { 3 },
            maximum: { 10 },
            ideal: { 10 })
        
        let flow = Flow(
            unit: .gallons,
            stockA: { from },
            stockB: { to },
            rate: { 1 })
        
        // The constraining value is the amount of liters in the "from" stock
        // 3 liters = 0.79 gallons
        XCTAssertEqual(
            flow.transferAmount(elapsedTime: 2),
            0.79,
            accuracy: 0.01)
    }
    
    func test_flow_transferAmount_zeroBecauseOfUnitIncompatability_all()
    {
        let from = Stock(
            unit: .metersSquared,
            current: { 100 },
            maximum: { 100 },
            ideal: { 0 })
        let to = Stock(
            unit: .calories,
            current: { 0 },
            maximum: { 100 },
            ideal: { 100 })
        
        let flow = Flow(
            unit: .feet,
            stockA: { from },
            stockB: { to },
            rate: { 1 })
        
        XCTAssertEqual(flow.transferAmount(elapsedTime: 1), 0)
    }
    
    func test_flow_transferAmount_zeroBecauseOfUnitIncompatability_stocks()
    {
        let from = Stock(
            unit: .acres,
            current: { 100 },
            maximum: { 100 },
            ideal: { 0 })
        let to = Stock(
            unit: .calories,
            current: { 0 },
            maximum: { 100 },
            ideal: { 100 })
        
        let flow = Flow(
            unit: .acres,
            stockA: { from },
            stockB: { to },
            rate: { 1 })
        
        XCTAssertEqual(flow.transferAmount(elapsedTime: 1), 0)
    }
    
    func test_flow_transferAmount_zeroBecauseOfUnitIncompatability_flow()
    {
        let from = Stock(
            unit: .calories,
            current: { 100 },
            maximum: { 100 },
            ideal: { 0 })
        let to = Stock(
            unit: .calories,
            current: { 0 },
            maximum: { 100 },
            ideal: { 100 })
        
        let flow = Flow(
            unit: .acres,
            stockA: { from },
            stockB: { to },
            rate: { 1 })
        
        XCTAssertEqual(flow.transferAmount(elapsedTime: 1), 0)
    }
    
    func test_flow_transferAmount_limitedByFlowAmount()
    {
        let from = Stock(
            unit: .calories,
            current: { 100 },
            maximum: { 100 },
            ideal: { 0 })
        let to = Stock(
            unit: .calories,
            current: { 0 },
            maximum: { 100 },
            ideal: { 100 })
        
        let flow = Flow(
            unit: .calories,
            stockA: { from },
            stockB: { to },
            rate: { 1 })
        
        XCTAssertEqual(flow.transferAmount(elapsedTime: 1), 1)
    }
    
    func test_flow_transferAmount_limitedByFromAmount()
    {
        let from = Stock(
            unit: .calories,
            current: { 87 },
            maximum: { 100 },
            ideal: { 0 })
        let to = Stock(
            unit: .calories,
            current: { 0 },
            maximum: { 100 },
            ideal: { 100 })
        
        let flow = Flow(
            unit: .calories,
            stockA: { from },
            stockB: { to },
            rate: { .infinity })
        
        XCTAssertEqual(flow.transferAmount(elapsedTime: 1), 87)
    }
    
    func test_flow_transferAmount_limitedByToAmount()
    {
        let from = Stock(
            unit: .joules,
            current: { 87 },
            maximum: { 100 },
            ideal: { 0 })
        let to = Stock(
            unit: .joules,
            current: { 96 },
            maximum: { 100 },
            ideal: { 100 })
        
        let flow = Flow(
            unit: .joules,
            stockA: { from },
            stockB: { to },
            rate: { .infinity })
        
        XCTAssertEqual(flow.transferAmount(elapsedTime: 1), 4)
    }
    
    func test_flow_update_elapsedTime()
    {
        let from = Stock(
            unit: .acres,
            current: { 100 },
            maximum: { 100 },
            ideal: { 0 })
        
        let to = Stock(
            unit: .acres,
            current: { 0 },
            maximum: { 100 },
            ideal: { 100 })
        
        let flow = Flow(
            unit: .acres,
            stockA: { from },
            stockB: { to },
            rate: { 1 })
        
        flow.update(0)
        XCTAssertEqual(from.current, 100)
        XCTAssertEqual(to.current, 0)
        
        flow.update(4)
        XCTAssertEqual(from.current, 96)
        XCTAssertEqual(to.current, 4)
        
        flow.update(5)
        XCTAssertEqual(from.current, 95)
        XCTAssertEqual(to.current, 5)
    }
    
    func test_flow_update_noElapsedTime()
    {
        let from = Stock(
            unit: .acres,
            current: { 100 },
            maximum: { 100 },
            ideal: { 100 })
        
        let to = Stock(
            unit: .acres,
            current: { 0 },
            maximum: { 100 },
            ideal: { 100 })
        
        let flow = Flow(
            unit: .acres,
            stockA: { from },
            stockB: { to },
            rate: { 1 })
        
        flow.update(0)
        XCTAssertEqual(from.current, 100)
        XCTAssertEqual(to.current, 0)
        
        flow.update(0)
        XCTAssertEqual(from.current, 100)
        XCTAssertEqual(to.current, 0)
    }
    
    func test_flow_transferAmount_longElapsedTime()
    {
        let from = Stock(
            unit: .acres,
            current: { 100 },
            maximum: { .greatestFiniteMagnitude },
            ideal: { 0 })
        
        let to = Stock(
            unit: .acres,
            current: { 0 },
            maximum: { .greatestFiniteMagnitude },
            ideal: { 100 })
        
        let flow = Flow(
            unit: .acres,
            stockA: { from },
            stockB: { to },
            rate: { 5 })
        
        flow.update(0)
        flow.update(3)
        
        XCTAssertEqual(from.current, 85)
        XCTAssertEqual(to.current, 15)
    }
    
    func test_flow_transferFromDifferentUnitsInSameunit()
    {
        let from = Stock(
            unit: .liters,
            current: { 100 },
            maximum: { .greatestFiniteMagnitude },
            ideal: { 0 })
        
        let to = Stock(
            unit: .gallons,
            current: { 0 },
            maximum: { .greatestFiniteMagnitude },
            ideal: { 100 })
        
        let flow = Flow(
            unit: .liters,
            stockA: { from },
            stockB: { to },
            rate: { 5 })
        
        flow.update(0)
        flow.update(1)
        
        XCTAssertEqual(from.current, 95)
        XCTAssertEqual(to.current, 1.32, accuracy: 0.01)
    }
    
    func test_transferAmount_isAbsoluteValue()
    {
        let from = Stock(
            unit: .liters,
            current: { 100 },
            maximum: { 100 },
            ideal: { 0 })
        let to = Stock(
            unit: .liters,
            current: { 0 },
            maximum: { 100 },
            ideal: { 100 })
        
        let flow = Flow(
            unit: .liters,
            stockA: { from },
            stockB: { to },
            rate: { 10 })
        
        let amount = flow.transferAmount(elapsedTime: 3)
        XCTAssertEqual(amount, 30)
    }
}
