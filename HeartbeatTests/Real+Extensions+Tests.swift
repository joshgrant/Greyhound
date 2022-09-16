//
//  Real+Extensions+Tests.swift
//  HeartbeatTests
//
//  Created by Joshua Grant on 9/15/22.
//

import XCTest
import Numerics
@testable import Heartbeat

final class Real_Extensions_Tests: XCTestCase
{
    func test_real_deltaWithValues()
    {
        let a: Double = 5
        let b: Double = 13
        
        let delta = Double.delta(a, b)
        XCTAssertEqual(delta, 8)
    }
    
    func test_real_deltaNoValues()
    {
        let a: Double? = nil
        let b: Double? = nil
        
        let delta = Double.delta(a, b)
        XCTAssertEqual(delta, 0)
    }
    
    func test_real_percentDelta()
    {
        let current: Double = 30
        let target: Double = 0
        let min: Double = 0
        let max: Double = 100
        let percentDelta = Double.percentDelta(
            a: current,
            b: target,
            minimum: min,
            maximum: max)
        XCTAssertEqual(percentDelta, 0.7)
    }
}
