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
    func test_system_init()
    {
        let system = System<Double>()
        XCTAssertNotNil(system)
    }
}
