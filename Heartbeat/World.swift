//
//  World.swift
//  Client
//
//  Created by Joshua Grant on 9/16/22.
//

import Foundation

open class World: System
{
    // MARK: - Variables
    
    public var iterations: Stock<Number>
    
    // MARK: - Initialization
    
    public init()
    {
        let iterations = Self.makeIterations()
        let counter = Self.makeCounter(with: iterations)
        
        self.iterations = iterations
        
        super.init(stocks: [iterations], flows: [counter])
    }
    
    // MARK: - Factory
    
    private static func makeIterations() -> Stock<Number>
    {
        .init(
            current: .init(value: 0, unit: .any),
            maximum: nil,
            ideal: .init(value: .greatestFiniteMagnitude, unit: .any))
    }
    
    private static func makeCounter(with iterations: Stock<Number>) -> Flow<Number>
    {
        .init(limit: .init(value: 1, unit: .any),
              stockA: .sink,
              stockB: iterations)
    }
}
