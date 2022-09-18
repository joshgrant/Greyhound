//
//  App.swift
//  Client
//
//  Created by Joshua Grant on 9/16/22.
//

import Foundation

class App<T>
{
    // MARK: - Variables

    var state: T
    var start: ((T) -> Void)?
    var input: (T, String) -> T
    var update: (T) -> T
    var display: (T) -> Void
    var shouldExit: (T) -> Bool
    var exit: ((T) -> Void)?

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
        state: T,
        start: ((T) -> Void)? = nil,
        input: @escaping (T, String) -> T,
        update: @escaping (T) -> T,
        display: @escaping (T) -> Void,
        shouldExit: @escaping (T) -> Bool,
        exit: ((T) -> Void)? = nil)
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
