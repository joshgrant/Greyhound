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
            thresholdRange: 0...100,
            flows: [])
        XCTAssertNotNil(procedure)
    }
    
    func test_procedure_isTriggered()
    {
        let stock = Stock<Double>(
            current: 0,
            ideal: 100,
            min: 0,
            max: 100,
            unit: UnitLength.astronomicalUnits)
        let procedure = Procedure<Double>(
            stock: stock,
            thresholdRange: 99...(.infinity),
            flows: [])
        XCTAssertTrue(procedure.canExecute)
    }
    
    func test_procedure_isNotTriggered()
    {
        let stock = Stock<Double>(
            current: 0,
            ideal: 0,
            min: 0,
            max: 100,
            unit: UnitLength.astronomicalUnits)
        let procedure = Procedure<Double>(
            stock: stock,
            thresholdRange: -.infinity...0,
            flows: [])
        XCTAssertFalse(procedure.canExecute)
    }
}
