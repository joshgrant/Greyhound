//
//  Unit+Tests.swift
//  HeartbeatTests
//
//  Created by Joshua Grant on 9/23/22.
//

import XCTest
@testable import Heartbeat

final class Unit_Tests: XCTestCase
{
    func test_unit_canConvertToAny()
    {
        XCTAssertTrue(Unit.acres.canConvert(to: .any))
    }
    
    func test_unit_anyCanConvertToUnit()
    {
        XCTAssertTrue(Unit.any.canConvert(to: .meters))
    }
    
    func test_unit_canConvert()
    {
        XCTAssertTrue(Unit.meters.canConvert(to: .feet))
    }
    
    func test_unit_canNotConvert()
    {
        XCTAssertFalse(Unit.meters.canConvert(to: .liters))
    }
    
    func test_unit_convertsCorrectlyFromAToB()
    {
        XCTAssertEqual(
            Unit.liters.convert(value: 5, to: .gallons),
            1.32,
            accuracy: 0.01)
    }
    
    func test_unit_convertsCorrectlyFromBToA()
    {
        XCTAssertEqual(
            Unit.gallons.convert(value: 5, to: .liters),
            18.93,
            accuracy: 0.01)
    }
}
