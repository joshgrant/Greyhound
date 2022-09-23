//
//  World.swift
//  Client
//
//  Created by Joshua Grant on 9/16/22.
//

import Foundation

public class World: System
{
    public var iterations: Stock
    
    // MARK: - Initialization
    
    public init()
    {
        let iterations = Self.makeIterations()
        let tick = Self.makeTick(with: iterations)
        
        self.iterations = iterations
        
        super.init(stocks: [iterations], flows: [tick])
    }
}

// MARK: - Factory

private extension World
{
    private static func makeIterations() -> Stock
    {
        Stock(
            unit: nil,
            current: { 0 },
            maximum: { .infinity },
            ideal: { .infinity })
    }
    
    private static func makeTick(with iterations: Stock) -> Flow
    {
        Flow(
            from: { .source },
            to: { iterations },
            rate: { 1 })
    }
}
