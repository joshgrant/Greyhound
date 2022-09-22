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
    
    // MARK: - Factory
    
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
            amount: { 1 },
            duration: { 0 })
    }
}

//import Foundation
//
//public class World
//{
//    public typealias IterationsModifier = (Int) -> Int
//
//    // MARK: - Variables
//
//    public var systems: [System]
//    public private(set) var iterations: Int
//
//    // MARK: - Initialization
//
//    public init(
//        systems: [System],
//        iterations: Int = 0)
//    {
//        self.systems = systems
//        self.iterations = iterations
//    }
//
//    // MARK: - Updates
//    
//    // This would originally be used with keyboard input,
//    // but there's probably a better way...
////    public func input(_ string: String)
////    {
////        print(string)
////    }
//
//    public func update(_ timeInterval: TimeInterval)
//    {
//        systems.forEach { $0.update(timeInterval) }
//        iterations += 1
//    }
//    
//    public func display()
//    {
//        // TODO: Is this necessary in a SpriteKit scenario?
//    }
//    
//    public func shouldExit() -> Bool
//    {
//        iterations >= 100
//    }
//}
