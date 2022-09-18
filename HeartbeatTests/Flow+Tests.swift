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
        let source: Stock = Stock(current: .infinity, ideal: 0, min: 0, max: .infinity, unit: UnitVolume.liters)
        let sink: Stock = Stock(current: 0, ideal: 0, min: 0, max: 100, unit: UnitVolume.liters)

        let flow = Flow(
            from: source,
            to: sink,
            amount: 1,
            duration: 0)
        XCTAssertNotNil(flow)
    }
}
