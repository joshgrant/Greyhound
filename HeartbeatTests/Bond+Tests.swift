//
//  Bond+Tests.swift
//  HeartbeatTests
//
//  Created by Joshua Grant on 9/19/22.
//

import XCTest
@testable import Heartbeat

final class Bond_Tests: XCTestCase
{
    func test_bond_deltaZero()
    {
        let stockA = Stock(
            unit: UnitEnergy.calories,
            current: { 0 },
            maximum: { 100 },
            ideal: { 10 })
        let stockB = Stock(
            unit: UnitEnergy.calories,
            current: { 20 },
            maximum: { 100 },
            ideal: { 10 })
        
        let bond = Bond(lhs: stockA, rhs: stockB)
        XCTAssertEqual(bond.delta, 0)
        XCTAssertEqual(bond.balance, 1)
    }
    
    func test_bond_deltaNegativeFifteen()
    {
        let stockA = Stock(
            unit: UnitEnergy.calories,
            current: { 10 },
            maximum: { 100 },
            ideal: { 50 })
        let stockB = Stock(
            unit: UnitEnergy.calories,
            current: { 65 },
            maximum: { 100 },
            ideal: { 40 })
        
        let bond = Bond(lhs: stockA, rhs: stockB)
        XCTAssertEqual(bond.delta, -15)
        XCTAssertEqual(bond.balance, 0.925)
    }
    
    func test_bond_deltaMaximum()
    {
        let stockA = Stock(
            unit: UnitEnergy.calories,
            current: { 0 },
            maximum: { 100 },
            ideal: { 100 })
        let stockB = Stock(
            unit: UnitEnergy.calories,
            current: { 0 },
            maximum: { 100 },
            ideal: { 100 })
        
        let bond = Bond(lhs: stockA, rhs: stockB)
        XCTAssertEqual(bond.delta, -200)
        XCTAssertEqual(bond.balance, 0)
    }
}
