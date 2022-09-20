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
    
}
//{
//    func test_system_init()
//    {
//        let system = System(stocks: [], flows: [])
//        XCTAssertNotNil(system)
//    }
//
//    func test_system_balance_allStocksInBalance()
//    {
//        let system = System(
//            stocks: [
//                .init(name: "", current: 1, ideal: { 1 }, min: 0, max: 1),
//                .init(name: "", current: 1, ideal: { 1 }, min: 0, max: 1)
//            ],
//            flows: [])
//        let balance = system.balance
//        XCTAssertEqual(balance, 1)
//    }
//
//    func test_system_balance_halfStocksInBalance()
//    {
//        let system = System(
//            stocks: [
//                .init(name: "", current: 1, ideal: { 1 }, min: 0, max: 1),
//                .init(name: "", current: 0, ideal: { 1 }, min: 0, max: 1)
//            ],
//            flows: [])
//        let balance = system.balance
//        XCTAssertEqual(balance, 0.5)
//    }
//
//    func test_system_balance_noStocksInBalance()
//    {
//        let system = System(
//            stocks: [
//                .init(name: "", current: 0, ideal: { 1 }, min: 0, max: 1),
//                .init(name: "", current: 0, ideal: { 1 }, min: 0, max: 1)
//            ],
//            flows: [])
//        let balance = system.balance
//        XCTAssertEqual(balance, 0)
//    }
//
//    func test_system_balance_withBondedStocks()
//    {
//        let a = Stock(current: 8, ideal: { 10 }, min: 0, max: 10)
//        let b = Stock(current: 11, ideal: { 10 }, min: 0, max: 10)
//        let bond = Bond(a: a, b: b)
//
//        let system = System(
//            stocks: [a, b],
//            flows: [])
//        system.bonds = [bond]
//        let balance = system.balance
//        XCTAssertEqual(balance, 0.95)
//    }
//}
