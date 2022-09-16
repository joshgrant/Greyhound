//
//  Procedure+Tests.swift
//  HeartbeatTests
//
//  Created by Joshua Grant on 9/15/22.
//

import XCTest
@testable import Heartbeat

final class Procedure_Tests: XCTestCase
{
    func test_procedure_init()
    {
        let stock = Stock<Double>(current: 0, ideal: 0, min: 0, max: 0, unit: UnitArea.acres)
        let procedure = Procedure<Double>(
            stock: stock,
            balanceRange: 0...1,
            flows: [])
        XCTAssertNotNil(procedure)
    }
    
    func test_procedure_isNotTriggered()
    {
        let stock = Stock<Double>(
            current: 0,
            ideal: 100,
            min: 0,
            max: 100,
            unit: UnitLength.astronomicalUnits)
        let procedure = Procedure<Double>(
            stock: stock,
            balanceRange: 0.001...1,
            flows: [])
        XCTAssertFalse(procedure.canExecute)
    }
    
    func test_procedure_isNotTriggeredNegative()
    {
        let stock = Stock<Double>(
            current: 0,
            ideal: 0,
            min: 0,
            max: 100,
            unit: UnitLength.astronomicalUnits)
        let procedure = Procedure<Double>(
            stock: stock,
            balanceRange: -1.0...(-0.0001),
            flows: [])
        XCTAssertFalse(procedure.canExecute)
    }
    
    func test_procedure_isTriggered()
    {
        let stock = Stock<Double>(
            current: 50,
            ideal: 100,
            min: 0,
            max: 100,
            unit: UnitSpeed.knots)
        let procedure = Procedure<Double>(
            stock: stock,
            balanceRange: 0.4...0.6, flows: [])
        XCTAssertTrue(procedure.canExecute)
    }
}
