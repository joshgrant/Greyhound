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
    func test_flow_init()
    {
        let source = Stock(name: "source", current: .infinity, ideal: { 0 }, min: 0, max: .infinity, unit: UnitVolume.liters)
        let sink = Stock(name: "sink", current: 0, ideal: { 0 }, min: 0, max: 100, unit: UnitVolume.liters)

        let flow = Flow(
            name: "init",
            from: source,
            to: sink,
            amount: 1,
            duration: 0)
        XCTAssertNotNil(flow)
    }
    
    func test_flow_transferAmountFromBottleneck()
    {
        let stockA = Stock(name: "from", current: 87, ideal: { 48 }, min: 36, max: 94)
        let stockB = Stock(name: "to", current: 17, ideal: { 57 }, min: 0, max: 58)
        
        let flow = Flow(name: "flow", from: stockA, to: stockB, amount: 1000, duration: 1.0)
        XCTAssertEqual(flow.transferAmount, 41)
    }
    
    func test_flow_transferAmountToBottleneck()
    {
        let stockA = Stock(name: "from", current: 87, ideal: { 48 }, min: 36, max: 94)
        let stockB = Stock(name: "to", current: 57, ideal: { 57 }, min: 0, max: 58)
        
        let flow = Flow(name: "flow", from: stockA, to: stockB, amount: 1000, duration: 1.0)
        XCTAssertEqual(flow.transferAmount, 1)
    }
    
    func test_flow_transferAmountFlowBottleneck()
    {
        let stockA = Stock(name: "from", current: 87, ideal: { 48 }, min: 36, max: 94)
        let stockB = Stock(name: "to", current: 17, ideal: { 57 }, min: 0, max: 1000)
        
        let flow = Flow(name: "flow", from: stockA, to: stockB, amount: 2, duration: 1.0)
        XCTAssertEqual(flow.transferAmount, 2)
    }
    
    func test_flow_noElapsedTime()
    {
        let stockA = Stock(name: "from", current: 87, ideal: { 48 }, min: 36, max: 94)
        let stockB = Stock(name: "to", current: 17, ideal: { 57 }, min: 0, max: 1000)
        
        let flow = Flow(name: "test", from: stockA, to: stockB, amount: 1, duration: 0.001)
        flow.update(0)
        flow.update(0)
        XCTAssertEqual(stockA.current, 87)
        XCTAssertEqual(stockB.current, 17)
    }
    
    func test_flow_elapsedTime()
    {
        let stockA = Stock(name: "from", current: 87, ideal: { 48 }, min: 36, max: 94)
        let stockB = Stock(name: "to", current: 17, ideal: { 57 }, min: 0, max: 1000)
        
        let flow = Flow(name: "test", from: stockA, to: stockB, amount: 4, duration: 1.99)
        
        flow.update(0)
        flow.update(2)
        XCTAssertEqual(stockA.current, 83)
        XCTAssertEqual(stockB.current, 21)
    }
}
