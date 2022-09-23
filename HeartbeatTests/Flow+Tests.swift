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
    func test_flow_transferAmount_zeroBecauseOfUnitIncompatability()
    {
        let from = Stock(
            unit: UnitArea.acres,
            current: { 100 },
            maximum: { 100 },
            ideal: { 0 })
        let to = Stock(
            unit: UnitEnergy.calories,
            current: { 0 },
            maximum: { 100 },
            ideal: { 100 })
        
        let flow = Flow(
            from: { from },
            to: { to },
            rate: { 1 })
        
        XCTAssertEqual(flow.transferAmount(elapsedTime: 1), 0)
    }
    
    func test_flow_transferAmount_limitedByFlowAmount()
    {
        let from = Stock(
            unit: UnitEnergy.calories,
            current: { 100 },
            maximum: { 100 },
            ideal: { 0 })
        let to = Stock(
            unit: UnitEnergy.calories,
            current: { 0 },
            maximum: { 100 },
            ideal: { 100 })
        
        let flow = Flow(
            from: { from },
            to: { to },
            rate: { 1 })
        
        XCTAssertEqual(flow.transferAmount(elapsedTime: 1), 1)
    }
    
    func test_flow_transferAmount_limitedByFromAmount()
    {
        let from = Stock(
            unit: UnitEnergy.calories,
            current: { 87 },
            maximum: { 100 },
            ideal: { 0 })
        let to = Stock(
            unit: UnitEnergy.calories,
            current: { 0 },
            maximum: { 100 },
            ideal: { 100 })
        
        let flow = Flow(
            from: { from },
            to: { to },
            rate: { .infinity })
        
        XCTAssertEqual(flow.transferAmount(elapsedTime: 1), 87)
    }
    
    func test_flow_transferAmount_limitedByToAmount()
    {
        let from = Stock(
            unit: UnitEnergy.calories,
            current: { 87 },
            maximum: { 100 },
            ideal: { 0 })
        let to = Stock(
            unit: UnitEnergy.calories,
            current: { 96 },
            maximum: { 100 },
            ideal: { 100 })
        
        let flow = Flow(
            from: { from },
            to: { to },
            rate: { .infinity })
        
        XCTAssertEqual(flow.transferAmount(elapsedTime: 1), 4)
    }
    
    func test_flow_update_elapsedTime()
    {
        let from = Stock(
            unit: UnitArea.acres,
            current: { 100 },
            maximum: { 100 },
            ideal: { 100 })
        
        let to = Stock(
            unit: UnitArea.acres,
            current: { 0 },
            maximum: { 100 },
            ideal: { 100 })
        
        let flow = Flow(
            from: { from },
            to: { to },
            rate: { 1 })
        
        flow.update(0)
        XCTAssertEqual(from.current, 100)
        XCTAssertEqual(to.current, 0)
        
        flow.update(4)
        XCTAssertEqual(from.current, 96)
        XCTAssertEqual(to.current, 4)
        
        flow.update(5)
        XCTAssertEqual(from.current, 91)
        XCTAssertEqual(to.current, 6)
    }
    
    func test_flow_update_noElapsedTime()
    {
        let from = Stock(
            unit: UnitArea.acres,
            current: { 100 },
            maximum: { 100 },
            ideal: { 100 })
        
        let to = Stock(
            unit: UnitArea.acres,
            current: { 0 },
            maximum: { 100 },
            ideal: { 100 })
        
        let flow = Flow(
            from: { from },
            to: { to },
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
            unit: UnitArea.acres,
            current: { 100 },
            maximum: { .infinity},
            ideal: { 100 })
        
        let to = Stock(
            unit: UnitArea.acres,
            current: { 0 }, maximum: { .infinity },
            ideal: { 0 })
        
        let flow = Flow(
            from: { from },
            to: { to },
            rate: { 5 })
        
        flow.update(0)
        flow.update(3)
        
        XCTAssertEqual(from.current, 85)
        XCTAssertEqual(to.current, 15)
    }
}
