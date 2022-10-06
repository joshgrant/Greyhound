//
//  Measurement+Tests.swift
//  HeartbeatTests
//
//  Created by Joshua Grant on 9/25/22.
//

import XCTest
@testable import Heartbeat

final class Measurement_Tests: XCTestCase
{
    // MARK: - Conversions
    
    func test_convertedToBase_liters()
    {
        let measurement = Measurement(value: 5, unit: .liters)
        let value = measurement.valueInBase
        XCTAssertEqual(value, 5)
    }
    
    func test_convertedToBase_gallons()
    {
        let measurement = Measurement(value: 6, unit: .gallons)
        let value = measurement.valueInBase
        XCTAssertEqual(value, 22.71, accuracy: 0.01)
    }
    
    func test_valueInUnit_metersToFeet()
    {
        let measurement = Measurement(value: 12, unit: .meters)
        let value = measurement.value(in: .feet)
        XCTAssertEqual(value, 39.37, accuracy: 0.01)
    }
    
    func test_valueInUnit_feetToMeters()
    {
        let measurement = Measurement(value: 12, unit: .feet)
        let value = measurement.value(in: .meters)
        XCTAssertEqual(value, 3.66, accuracy: 0.01)
    }
    
    // MARK: - Comparable
    
    func test_comparable_lessThan()
    {
        let measurementA = Measurement(value: 5, unit: .meters)
        let measurementB = Measurement(value: 3, unit: .meters)
        XCTAssertTrue(measurementA > measurementB)
    }
    
    func test_comparable_equal()
    {
        let measurementA = Measurement(value: 5, unit: .meters)
        let measurementB = Measurement(value: 5, unit: .meters)
        XCTAssertTrue(measurementA == measurementB)
    }
    
    // MARK: Arithmetic
    
    func test_add()
    {
        let measurementA = Measurement(value: 5, unit: .meters)
        let measurementB = Measurement(value: 5, unit: .meters)
        let value = measurementA + measurementB
        XCTAssertEqual(value.value, 10)
    }
    
    func test_subtract()
    {
        let measurementA = Measurement(value: 5, unit: .meters)
        let measurementB = Measurement(value: 7, unit: .meters)
        let value = measurementA - measurementB
        XCTAssertEqual(value.value, -2)
    }
    
    func test_subtractGest()
    {
        var measurementA = Measurement(value: 6, unit: .meters)
        let measurementB = Measurement(value: 5, unit: .meters)
        measurementA -= measurementB
        XCTAssertEqual(measurementA.value, 1)
    }
    
    func test_addGets()
    {
        var measurementA = Measurement(value: -2, unit: .meters)
        let measurementB = Measurement(value: 3, unit: .meters)
        measurementA += measurementB
        XCTAssertEqual(measurementA.value, 1)
    }
    
    // MARK: - Arithmetic conversions
    
    func test_converted_add()
    {
        let measurementA = Measurement(value: 3, unit: .liters)
        let measurementB = Measurement(value: -1, unit: .gallons)
        let value = measurementA + measurementB
        XCTAssertEqual(value.value, -0.79, accuracy: 0.01)
    }
    
    func test_converted_subtract()
    {
        let measurementA = Measurement(value: 6, unit: .meters)
        let measurementB = Measurement(value: 5, unit: .feet)
        let value = measurementA - measurementB
        XCTAssertEqual(value.value, 4.48, accuracy: 0.01)
    }
    
    func test_converted_addGets()
    {
        var measurementA = Measurement(value: 3, unit: .liters)
        let measurementB = Measurement(value: -1, unit: .gallons)
        measurementA += measurementB
        XCTAssertEqual(measurementA.value, -0.79, accuracy: 0.01)
    }
    
    func test_converted_subtractGets()
    {
        var measurementA = Measurement(value: 6, unit: .meters)
        let measurementB = Measurement(value: 5, unit: .feet)
        measurementA -= measurementB
        XCTAssertEqual(measurementA.value, 4.48, accuracy: 0.01)
    }
}
