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
//    func test_pressure_noStocks()
//    {
//        let system = System()
//        XCTAssertEqual(system.pressure, 1)
//    }
//    
//    func test_pressure_oneStock()
//    {
//        let system = System()
//        system.stocks = [
//            .init(
//                unit: .acres,
//                current: { 5 },
//                maximum: { 100 },
//                ideal: { 20 })
//        ]
//        
//        XCTAssertEqual(system.pressure, 0.85)
//    }
//    
//    func test_pressure_twoStocks()
//    {
//        let system = System()
//        system.stocks = [
//            .init(
//                unit: .acres,
//                current: { 5 },
//                maximum: { 100 },
//                ideal: { 20 }),
//            .init(
//                unit: .acres,
//                current: { 20 },
//                maximum: { 100 },
//                ideal: { 50 })
//        ]
//        XCTAssertEqual(system.pressure, 0.775)
//    }
//    
//    func test_convertToStock()
//    {
//        let system = System()
//        system.stocks = [
//            .init(
//                unit: .gallons,
//                current: { 5 },
//                maximum: { 100 },
//                ideal: { 20 }),
//            .init(
//                unit: .acres,
//                current: { 20 },
//                maximum: { 100 },
//                ideal: { 50 })
//        ]
//        let stock = system.convertToStock()
//        XCTAssertEqual(stock.current, 25)
//        XCTAssertEqual(stock.maximum, 200)
//        XCTAssertEqual(stock.ideal, 70)
//        XCTAssertEqual(stock.pressure, -45)
//    }
//    
//    func test_updateSystem()
//    {
//        let system = System()
//        let stock = Stock(
//            unit: .liters,
//            current: { 50 },
//            maximum: { 100 },
//            ideal: { 75 })
//        let flow = try! Flow(
//            unit: .liters,
//            stockA: { stock },
//            stockB: { .sink },
//            limit: { 1 })
//        
//        system.stocks = [stock]
//        system.flows = [flow]
//        
//        print(stock.pressure)
//        print(Stock.sink.pressure)
//        
//        system.update(0)
//        system.update(1)
//        XCTAssertEqual(stock.current, 49)
//        
//        system.update(49)
//        XCTAssertEqual(stock.current, 1)
//        
//        system.update(50)
//        XCTAssertEqual(stock.current, 0)
//        
//        system.update(51)
//        XCTAssertEqual(stock.current, 0)
//    }
}
