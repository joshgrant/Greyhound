//
//  World.swift
//  Client
//
//  Created by Joshua Grant on 9/16/22.
//

import Foundation

public class World
{
    public typealias IterationsModifier = (Int) -> Int

    // MARK: - Variables

    public var systems: [any System]
    public private(set) var iterations: Int

    // MARK: - Initialization

    public init(
        systems: [any System],
        iterations: Int = 0)
    {
        self.systems = systems
        self.iterations = iterations
    }

    // MARK: - Updates
    
    // This would originally be used with keyboard input,
    // but there's probably a better way...
//    public func input(_ string: String)
//    {
//        print(string)
//    }

    public func update(_ timeInterval: TimeInterval)
    {
        print(timeInterval)
        systems.forEach { $0.update(timeInterval) }
        iterations += 1
    }
    
    public func display()
    {
        // TODO: Is this necessary in a SpriteKit scenario?
    }
    
    public func shouldExit() -> Bool
    {
        iterations >= 100
    }
}
