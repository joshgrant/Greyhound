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
    func test_canConvertToAny()
    {
        XCTAssertTrue(Unit.feet.canConvert(to: .feet))
//        XCTAssertTrue(Unit.canConvert(.pounds to: Unit<Number>.any))
    }
    
//    func test_canConvertFromAny()
//    {
//        XCTAssertTrue(Unit.any.canConvert(to: .kilograms))
//        XCTAssertTrue(Unit.any.canConvert(to: .liters))
//    }
//
//    func test_canConvertToUnitOfSameType()
//    {
//        XCTAssertFalse(Unit.feet.canConvert(to: .meters))
//        XCTAssertFalse(Unit.pounds.canConvert(to: .kilograms))
//    }
//
//    func test_doesNotConvertBetweenIncompatibleTypes()
//    {
//        XCTAssertFalse(Unit.feet.canConvert(to: .pounds))
//        XCTAssertFalse(Unit.pounds.canConvert(to: .feet))
//    }
}
