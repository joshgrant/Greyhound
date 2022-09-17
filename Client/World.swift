//
//  World.swift
//  Client
//
//  Created by Joshua Grant on 9/16/22.
//

import Foundation

struct World<T: FloatingPoint>
{
    typealias SystemModifier = (System<T>) -> System<T>
    typealias IterationsModifier = (Int) -> Int
    
    // MARK: - Variables
    
    var system: System<T>
    
    let iterations: Int
    
    // MARK: - Initialization
    
    init(system: System<T>, iterations: Int)
    {
        self.system = system
        self.iterations = iterations
    }
    
    init(world: World<T>, system: System<T>? = nil, iterations: Int? = nil)
    {
        self.init(
            system: system ?? world.system,
            iterations: iterations ?? world.iterations)
    }
    
    init(world: World<T>, systemModifier: SystemModifier? = nil, iterationsModifier: IterationsModifier? = nil)
    {
        self.init(
            world: world,
            system: systemModifier?(world.system) ?? world.system,
            iterations: iterationsModifier?(world.iterations) ?? world.iterations)
    }
    
    // MARK: - Updates
    
    static func update(_ world: World<T>) -> World<T>
    {
        World(
            world: world,
            systemModifier: System<T>.modifier,
            iterationsModifier: iterationsModifier)
    }
    
    static func display(_ world: World)
    {
        // TODO: Render to a Metal context
    }
    
    static func shouldExit(_ world: World) -> Bool
    {
        return world.iterations >= 100
    }
    
    // MARK: - Modifiers
    
    static func iterationsModifier(_ iterations: Int) -> Int
    {
        return iterations + 1
    }
}
