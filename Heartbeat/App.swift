//
//  App.swift
//  Client
//
//  Created by Joshua Grant on 9/16/22.
//

import Foundation

class App
{
    // MARK: - Variables

    var state: World
    var start: ((World) -> Void)?
    var input: (World, String) -> World
    var update: (World) -> World
    var display: (World) -> Void
    var shouldExit: (World) -> Bool
    var exit: ((World) -> Void)?

    private lazy var inputThread: Thread = {
        Thread { [self] in
            while !shouldExit(state)
            {
                guard let read = readLine() else { return }
                state = input(state, read)
            }
        }
    }()

    private lazy var eventTimer: Timer = {
        return Timer(timeInterval: 0.001, repeats: true) { [self] _ in
            state = update(state)
            display(state)
        }
    }()

    // MARK: - Initialization

    init(
        state: World,
        start: ((World) -> Void)? = nil,
        input: @escaping (World, String) -> World,
        update: @escaping (World) -> World,
        display: @escaping (World) -> Void,
        shouldExit: @escaping (World) -> Bool,
        exit: ((World) -> Void)? = nil)
    {
        self.state = state
        self.start = start
        self.input = input
        self.update = update
        self.display = display
        self.shouldExit = shouldExit
        self.exit = exit
    }

    // MARK: - Functions

    func run()
    {
        start?(state)
        startInputLoop()
        startUpdateLoop()
        exit?(state)
    }

    private func startInputLoop()
    {
        inputThread.start()
    }

    private func startUpdateLoop()
    {
        RunLoop.current.add(eventTimer, forMode: .common)
    }
}
