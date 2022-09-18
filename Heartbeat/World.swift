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
    
    func input(_ string: String)
    {
        print(string)
    }

    func update(_ timeInterval: TimeInterval)
    {
        systems.forEach { $0.update() }
        iterations += 1
    }
    
    func display()
    {
        
    }
    
    func shouldExit() -> Bool
    {
        iterations >= 100
    }
}
