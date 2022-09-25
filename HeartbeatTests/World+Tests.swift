//
//  World+Tests.swift
//  HeartbeatTests
//
//  Created by Joshua Grant on 9/25/22.
//

import XCTest
@testable import Heartbeat

final class World_Tests: XCTestCase
{
    func test_worldStocks()
    {
        let world = World()
        XCTAssertEqual(world.iterations.current.value, 0)
        
        world.update(0)
        XCTAssertEqual(world.iterations.current.value, 0)
        
        world.update(1)
        XCTAssertEqual(world.iterations.current.value, 1)
        
        world.update(56)
        XCTAssertEqual(world.iterations.current.value, 56)
    }
}
