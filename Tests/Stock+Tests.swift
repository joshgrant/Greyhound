//
//  Stock+Tests.swift
//  HeartbeatTests
//
//  Created by Joshua Grant on 9/15/22.
//

import XCTest
@testable import Heartbeat

final class Stock_Tests: XCTestCase
{
    func test_pressure_positive()
    {
        let stock = Stock(
            current: .init(value: 5, unit: .gallons),
            maximum: .init(value: 5, unit: .liters),
            ideal: .init(value: 1, unit: .gallons))
        let pressure = stock.pressure.value
        XCTAssertGreaterThan(pressure, 0)
    }
    
    func test_pressure_negative()
    {
        let stock = Stock(
            current: .init(value: 1, unit: .gallons),
            maximum: .init(value: 30, unit: .liters),
            ideal: .init(value: 5, unit: .gallons))
        let pressure = stock.pressure.value
        XCTAssertLessThan(pressure, 0)
    }
    
    func test_pressure_positiveValue()
    {
        let stock = Stock(
            current: .init(value: 6, unit: .gallons),
            maximum: .init(value: 10, unit: .gallons),
            ideal: .init(value: 1, unit: .gallons))
        let pressure = stock.pressure.value
        XCTAssertEqual(pressure, 5)
    }
    
    func test_pressure_negativeValue()
    {
        let stock = Stock(
            current: .init(value: 1, unit: .gallons),
            maximum: .init(value: 10, unit: .gallons),
            ideal: .init(value: 7, unit: .gallons))
        let pressure = stock.pressure.value
        XCTAssertEqual(pressure, -6)
    }
    
    func test_pressure_no_maximum()
    {
        let stock = Stock(
            current: .init(value: 5, unit: .gallons),
            maximum: nil,
            ideal: .init(value: 1, unit: .gallons))
        let pressure = stock.pressure.value
        XCTAssertEqual(pressure, 4)
    }
    
    func test_remainingCapacity_noMaximum()
    {
        let stock = Stock(
            current: .init(value: 4, unit: .meters),
            maximum: nil,
            ideal: .init(value: 8, unit: .meters))
        let value = stock.remainingCapacity?.value
        XCTAssertNil(value)
    }
    
    func test_remainingCapacity_maximum()
    {
        let stock = Stock(
            current: .init(value: 4, unit: .meters),
            maximum: .init(value: 10, unit: .meters),
            ideal: .init(value: 6, unit: .meters))
        let value = stock.remainingCapacity?.value
        XCTAssertEqual(value, 6)
    }
    
    func test_remainingCapacity_none()
    {
        let stock = Stock(
            current: .init(value: 10, unit: .meters),
            maximum: .init(value: 10, unit: .meters),
            ideal: .init(value: 6, unit: .meters))
        let value = stock.remainingCapacity?.value
        XCTAssertEqual(value, 0)
    }

    func test_remainingAmount()
    {
        let stock = Stock(
            current: .init(value: 3, unit: .meters),
            maximum: .init(value: 5, unit: .meters),
            ideal: .init(value: 4, unit: .meters))
        let value = stock.remainingAmount.value
        XCTAssertEqual(value, 3)
    }
}
