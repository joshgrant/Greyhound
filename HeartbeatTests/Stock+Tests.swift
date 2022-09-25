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
//    func test_delta_noDelta()
//    {
//        let stock = Stock(
//            unit: .joules,
//            current: { 23 },
//            maximum: { 200 },
//            ideal: { 23 })
//        
//        XCTAssertEqual(stock.pressure, 0)
//    }
//    
//    func test_delta_negativeDelta()
//    {
//        let stock = Stock(
//            unit: .joules,
//            current: { 17 },
//            maximum: { 100 },
//            ideal: { 40 })
//        
//        XCTAssertEqual(stock.pressure, -23)
//    }
//    
//    func test_delta_positiveDelta()
//    {
//        let stock = Stock(
//            unit: .joules,
//            current: { 91 },
//            maximum: { 1000 },
//            ideal: { 12 })
//        
//        XCTAssertEqual(stock.pressure, 79)
//    }
//    
//    func test_pressure_zeroDelta()
//    {
//        let stock = Stock(
//            unit: .joules,
//            current: { 40 },
//            maximum: { 100 },
//            ideal: { 40 })
//        
//        XCTAssertEqual(stock.pressure, 0)
//    }
//    
//    func test_compare_pressureMagnitude_equalUnits()
//    {
//        let stockA = Stock(unit: .joules, current: { 5 }, maximum: { 10 }, ideal: { 10 })
//        let stockB = Stock(unit: .joules, current: { 0 }, maximum: { 10 }, ideal: { 10 })
//        
//        XCTAssertGreaterThan(abs(stockB.pressure), abs(stockA.pressure))
//    }
//    
//    func test_compare_pressure_unequalUnits()
//    {
//        let stockA = Stock(
//            unit: .calories,
//            current: { 5 },
//            maximum: { 10 },
//            ideal: { 10 })
//        let stockB = Stock(
//            unit: .joules,
//            current: { 0 },
//            maximum: { 10 },
//            ideal: { 10 })
//        
//        XCTAssertGreaterThan(
//            abs(stockA.pressureInBase),
//            abs(stockB.pressureInBase))
//    }
//    
//    func test_sink_pressure()
//    {
//        XCTAssertEqual(Stock.sink.pressure, -.greatestFiniteMagnitude)
//    }
//    
//    func test_source_pressure()
//    {
//        XCTAssertEqual(Stock.source.pressure, .greatestFiniteMagnitude)
//    }
//    
//    func test_sink_source_equalizedPressure()
//    {
//        let flow = try! Flow(
//            unit: .any,
//            stockA: { .sink },
//            stockB: { .source },
//            limit: { 1000 })
//        
//        flow.update(0)
//        flow.update(1)
//        
//        XCTAssertEqual(Stock.sink.pressure, -.greatestFiniteMagnitude)
//        XCTAssertEqual(Stock.source.pressure, .greatestFiniteMagnitude)
//        
//        XCTAssertEqual(Stock.sink.current, 0)
//        XCTAssertEqual(Stock.source.current, .greatestFiniteMagnitude)
//    }
}
