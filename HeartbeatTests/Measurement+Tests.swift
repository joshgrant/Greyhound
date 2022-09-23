//
//  Measurement+Tests.swift
//  HeartbeatTests
//
//  Created by Joshua Grant on 9/23/22.
//

import XCTest
@testable import Heartbeat

final class Measurement_Tests: XCTestCase
{    
    func test_measurement_convertsCorrectly()
    {
        let measurement = Measurement(value: 5, unit: .meters)
        let conversion = measurement.converted(to: .feet)
        XCTAssertEqual(conversion?.value, 16.4)
    }
}
