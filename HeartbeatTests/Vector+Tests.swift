//
//  Vector+Tests.swift
//  HeartbeatTests
//
//  Created by Joshua Grant on 9/15/22.
//

import XCTest
@testable import Heartbeat

final class Vector_Tests: XCTestCase
{
    func test_vector_init()
    {
        let vector = Vector<Double>()
        XCTAssertNotNil(vector)
    }
    
    func test_vector_initWithValues()
    {
        let vector = Vector<Float>(1, 2, 3)
        XCTAssertEqual(vector.x, 1)
        XCTAssertEqual(vector.y, 2)
        XCTAssertEqual(vector.z, 3)
    }

    func test_vector_distance()
    {
        let vectorA = Vector<Double>(5, 12, 13)
        let vectorB = Vector<Double>(4, 5, 6)
        
        let distance = vectorA ∆ vectorB
        XCTAssertEqual(distance, 9.949, accuracy: 0.01)
    }
    
    func test_vector_subtract()
    {
        let vectorA = Vector<Double>(1, 2, 3)
        let vectorB = Vector<Double>(4, 5, 6)
        
        let result = vectorA - vectorB
        XCTAssertEqual(result, Vector<Double>(-3, -3, -3))
    }
    
    func test_vector_add()
    {
        let vectorA = Vector<Double>(1, 2, 3)
        let vectorB = Vector<Double>(-3, 2, 0)
        
        let result = vectorA + vectorB
        XCTAssertEqual(result, Vector<Double>(-2, 4, 3))
    }
    
    func test_vector_subtractUnaligned()
    {
        let vectorA = Vector<Double>(1, 2, 3, 4)
        let vectorB = Vector<Double>(1)
        let result = vectorA - vectorB
        XCTAssertEqual(result, Vector<Double>(0))
    }
}
