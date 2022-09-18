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
        let source = Stock1D(current: .infinity, ideal: 0, min: 0, max: .infinity, unit: UnitVolume.liters)
        let sink = Stock1D(current: 0, ideal: 0, min: 0, max: 100, unit: UnitVolume.liters)

        let flow = Flow1D(
            from: source,
            to: sink,
            amount: 1,
            duration: 0)
        XCTAssertNotNil(flow)
    }
}
