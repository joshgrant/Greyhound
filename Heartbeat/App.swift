//
//  App.swift
//  Client
//
//  Created by Joshua Grant on 9/16/22.
//

import Foundation

public class App
{
    // MARK: - Variables

    public var world: World

    private lazy var inputThread: Thread = {
        Thread { [self] in
            while !world.shouldExit()
            {
                guard let line = readLine() else { return }
                world.input(line)
            }
        }
    }()

    private lazy var eventTimer: Timer = {
        return Timer(timeInterval: 0.001, repeats: true) { [self] timer in
            world.update(Date.now.timeIntervalSince1970) // TODO: Implement a tick function
            world.display()
        }
    }()

    // MARK: - Initialization

    public init(world: World? = nil)
    {
        self.world = world ?? World(systems: [])
        
        startInputLoop()
        startUpdateLoop()
    }

    // MARK: - Functions

    private func startInputLoop()
    {
        inputThread.start()
    }

    private func startUpdateLoop()
    {
        RunLoop.current.add(eventTimer, forMode: .common)
    }
}
