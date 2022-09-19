//
//  Flow1D+Tests.swift
//  HeartbeatTests
//
//  Created by Joshua Grant on 9/15/22.
//

import XCTest
@testable import Heartbeat

final class Flow1D_Tests: XCTestCase
{
    func test_flow1D_init()
    {
        let source = Stock1D(name: "source", current: .infinity, ideal: 0, min: 0, max: .infinity, unit: UnitVolume.liters)
        let sink = Stock1D(name: "sink", current: 0, ideal: 0, min: 0, max: 100, unit: UnitVolume.liters)

        let flow = Flow1D(
            name: "init",
            from: source,
            to: sink,
            amount: 1,
            duration: 0)
        XCTAssertNotNil(flow)
    }
    
    func test_flow1D_transferAmountFromBottleneck()
    {
        let stockA = Stock1D(name: "from", current: 87, ideal: 48, min: 36, max: 94)
        let stockB = Stock1D(name: "to", current: 17, ideal: 57, min: 0, max: 58)
        
        let flow = Flow1D(name: "flow", from: stockA, to: stockB, amount: 1000, duration: 1.0)
        XCTAssertEqual(flow.transferAmount, 41)
    }
    
    func test_flow1D_transferAmountToBottleneck()
    {
        let stockA = Stock1D(name: "from", current: 87, ideal: 48, min: 36, max: 94)
        let stockB = Stock1D(name: "to", current: 57, ideal: 57, min: 0, max: 58)
        
        let flow = Flow1D(name: "flow", from: stockA, to: stockB, amount: 1000, duration: 1.0)
        XCTAssertEqual(flow.transferAmount, 1)
    }
    
    func test_flow1D_transferAmountFlowBottleneck()
    {
        let stockA = Stock1D(name: "from", current: 87, ideal: 48, min: 36, max: 94)
        let stockB = Stock1D(name: "to", current: 17, ideal: 57, min: 0, max: 1000)
        
        let flow = Flow1D(name: "flow", from: stockA, to: stockB, amount: 2, duration: 1.0)
        XCTAssertEqual(flow.transferAmount, 2)
    }
    
    func test_flow1D_elapsedTime()
    {
        let stockA = Stock1D(name: "from", current: 87, ideal: 48, min: 36, max: 94)
        let stockB = Stock1D(name: "to", current: 17, ideal: 57, min: 0, max: 1000)
        
        let start = Date.now
        let flow = Flow1D(name: "test", from: stockA, to: stockB, amount: 1, duration: 3)
        
        XCTFail()
    }
}
