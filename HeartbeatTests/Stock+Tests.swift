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
    func test_stock_init()
    {
        let stock = Stock<Double>(
            current: 0,
            ideal: 50,
            min: 0,
            max: 100)
        XCTAssertNotNil(stock)
    }
}
