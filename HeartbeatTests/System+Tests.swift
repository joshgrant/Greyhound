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
    
    func test_system_leastBalancedStock()
    {
        var system = System<Double>()
        system.stocks = [
            .init(current: 50, ideal: 100, min: 0, max: 100, unit: UnitArea.acres),
            .init(current: 75, ideal: 100, min: 0, max: 100, unit: UnitArea.acres)
        ]
        let leastBalanced = system.leastBalanced
        XCTAssertEqual(leastBalanced?.current, 50)
    }
    
    func test_system_findsProcedureForStock()
    {
        let system = System<Double>()
        let from = Stock<Double>(current: 50, ideal: 100, min: 0, max: 100)
        let to = Stock<Double>(current: 60, ideal: 100, min: 0, max: 100)
        let flow = Flow<Double>(from: from, to: to)
        let procedureA = Procedure<Double>(stock: from, balanceRange: 0.2...0.3, flows: [flow])
        let procedureB = Procedure<Double>(stock: from, balanceRange: 0.4...0.55, flows: [flow])
        
        system.stocks = [from, to]
        system.flows = [flow]
        system.procedures = [procedureA, procedureB]
        
        let procedure = system.availableProcedure(for: from)
        XCTAssertEqual(procedure, procedureB)
    }
    
    func test_system_doesNotFindProcedureForStock()
    {
        let system = System<Double>()
        let from = Stock<Double>(current: 50, ideal: 100, min: 0, max: 100)
        let to = Stock<Double>(current: 60, ideal: 100, min: 0, max: 100)
        let flow = Flow<Double>(from: from, to: to)
        let procedureA = Procedure<Double>(stock: from, balanceRange: 0.2...0.3, flows: [flow])
        let procedureB = Procedure<Double>(stock: from, balanceRange: 0.6...0.8, flows: [flow])
        
        system.stocks = [from, to]
        system.flows = [flow]
        system.procedures = [procedureA, procedureB]
        
        let procedure = system.availableProcedure(for: from)
        XCTAssertNil(procedure)
    }
}
