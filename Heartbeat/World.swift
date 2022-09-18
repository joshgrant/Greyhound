//
//  World.swift
//  Client
//
//  Created by Joshua Grant on 9/16/22.
//

import Foundation
import Spatial

// A world should definetly not be genericized like this...
class World
{
    typealias IterationsModifier = (Int) -> Int

    // MARK: - Variables

    var systems: [any System]
    let iterations: Int

    // MARK: - Initialization

    init(
        systems: [any System],
        iterations: Int)
    {
        self.systems = systems
        self.iterations = iterations
    }

    convenience init(
        world: World,
        systems: [any System]? = nil,
        iterations: Int? = nil)
    {
        self.init(
            systems: systems ?? world.systems,
            iterations: iterations ?? world.iterations)
    }

    convenience init(
        world: World,
        systems: [any System]? = nil,
        iterationsModifier: IterationsModifier? = nil)
    {
        self.init(
            world: world,
            systems: systems ?? world.systems,
            iterations: iterationsModifier?(world.iterations) ?? world.iterations)
    }

    // MARK: - Updates

    static func input(_ world: World, input: String) -> World
    {
        print(input)
        return world
    }

    static func update(_ world: World) -> World
    {
        World(
            world: world,
            iterationsModifier: iterationsModifier)
    }

    static func display(_ world: World)
    {
        // This is where we want to render the world to the screen
    }

    static func shouldExit(_ world: World) -> Bool
    {
        world.iterations >= 100
    }

    // MARK: - Modifiers

    static func iterationsModifier(_ iterations: Int) -> Int
    {
        iterations + 1
    }
}
