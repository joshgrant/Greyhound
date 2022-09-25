//
//  Utility+Tests.swift
//  HeartbeatTests
//
//  Created by Joshua Grant on 9/25/22.
//

import XCTest
@testable import Heartbeat

final class Utility_Tests: XCTestCase
{
    func test_minimum_nullMeasurements()
    {
        let measurementA = Measurement(value: 5, unit: .liters)
        let measurementB = Measurement(value: 3, unit: .liters)
        
        let min = min(measurementA, measurementB, nil)
        
        XCTAssertEqual(min, measurementB)
    }
    
    func test_minimum_nullMeasurement_zero()
    {
        let first: Double? = 0
        
        let min = min(first, 4, 8, 16, 2)
        
        XCTAssertEqual(min, 0)
    }
    
    func test_doubleMultipliedBy()
    {
        XCTAssertEqual(5.multiplied(by: 3), 15)
    }
    
    func test_doubleMultipliedByNil()
    {
        let value: Double? = nil
        XCTAssertNil(value?.multiplied(by: 3))
    }
}
