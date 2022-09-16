//
//  main.swift
//  Client
//
//  Created by Joshua Grant on 9/15/22.
//

import Foundation

struct Stock<T: FloatingPoint>
{
    typealias CurrentModifier = (T) -> T
    
    // MARK: - Variables
    
    var uuid = UUID()
    
    let current: T
    let ideal: T
    
    let minimum: T
    let maximum: T
    
    var balance: T
    {
        let delta = abs(current - ideal)
        let scale = max(maximum - ideal, ideal - minimum)
        return 1 - delta / scale
    }
    
    // MARK: - Initialization
    
    init(current: T, ideal: T, minimum: T, maximum: T)
    {
        self.current = current
        self.ideal = ideal
        self.minimum = minimum
        self.maximum = maximum
    }
    
    init(stock: Stock, current: T? = nil, ideal: T? = nil, minimum: T? = nil, maximum: T? = nil)
    {
        self.init(
            current: current ?? stock.current,
            ideal: ideal ?? stock.ideal,
            minimum: minimum ?? stock.minimum,
            maximum: maximum ?? stock.maximum)
    }
    
    init(stock: Stock, modifier: CurrentModifier)
    {
        self.init(
            stock: stock,
            current: modifier(stock.current))
    }
}

extension Stock: Equatable
{
    
}

struct Flow<T: FloatingPoint>
{
    typealias StockModifier = (Stock<T>) -> Stock<T>
    
    // MARK: - Variables
    
    var uuid = UUID()
    
    var from: Stock<T>
    var to: Stock<T>
    
    var amount: T
    
    // MARK: - Initialization
    
    init(from: Stock<T>, to: Stock<T>, amount: T)
    {
        precondition(amount > 0)
        
        self.from = from
        self.to = to
        self.amount = amount
    }
    
    init(flow: Flow, from: Stock<T>? = nil, to: Stock<T>? = nil, amount: T? = nil)
    {
        self.init(
            from: from ?? flow.from,
            to: to ?? flow.to,
            amount: amount ?? flow.amount)
    }
    
    init(
        flow: Flow,
        fromModifier: StockModifier,
        toModifier: StockModifier,
        amount: T? = nil)
    {
        self.init(
            flow: flow,
            from: fromModifier(flow.from),
            to: toModifier(flow.to),
            amount: amount)
    }
}

extension Flow: Equatable
{
    
}

struct System<T: FloatingPoint>
{
    typealias StocksModifier = ([Stock<T>]) -> [Stock<T>]
    typealias FlowsModifier = ([Flow<T>]) -> [Flow<T>]
    
    // MARK: - Variables
    
    var uuid = UUID()
    
    var stocks: [Stock<T>]
    var flows: [Flow<T>]
    
    var balance: T
    {
        var total: T = 0
        var ideal: T = 0
        
        for stock in stocks
        {
            total += stock.balance
            ideal += 1
        }
        
        if ideal == 0 { return 1 }
        return total / ideal
    }
    
    // MARK: - Initialization
    
    init(stocks: [Stock<T>], flows: [Flow<T>])
    {
        self.stocks = stocks
        self.flows = flows
    }
    
    init(system: System, stocks: [Stock<T>]? = nil, flows: [Flow<T>]? = nil)
    {
        self.init(
            stocks: stocks ?? system.stocks,
            flows: flows ?? system.flows)
    }
    
    init(system: System, stocksModifier: StocksModifier, flowsModifier: FlowsModifier)
    {
        self.init(
            system: system,
            stocks: stocksModifier(system.stocks),
            flows: flowsModifier(system.flows))
    }
}

extension System: Equatable
{
    
}

struct World
{
    // MARK: - Variables
    
    // TODO: This is just temporary
    var system: System<Double>
    
    let iterations: Int
    
    // MARK: - Initialization
    
    init(system: System<Double>, iterations: Int)
    {
        self.system = system
        self.iterations = iterations
    }
    
    init(world: World, system: System<Double>? = nil, iterations: Int? = nil)
    {
        self.init(
            system: system ?? world.system,
            iterations: iterations ?? world.iterations)
    }
    
    init(world: World, systemModifier: (System<Double>) -> System<Double>, iterationsModifier: (Int) -> Int)
    {
        self.init(
            world: world,
            system: systemModifier(world.system),
            iterations: iterationsModifier(world.iterations))
    }
    
    // MARK: - Updates
    
    static func update(_ world: World) -> World
    {
        for flow in world.system.flows
        {
            run(flow: flow, world: world)
        }
        
        return World(world: world, systemModifier: { $0 }, iterationsModifier: { $0 + 1})
    }
    
    static func run(flow: Flow<Double>, world: World) -> World
    {
        World(
            world: world,
            systemModifier: { system in
                System(
                    system: system,
                    stocksModifier: { stocks in
                        // Create a new array that changes each of the stocks associated with the flow
                        // How can we check equality?
                        for stock in stocks
                        {
                            print(flow.from == stock)
                            print(flow.to == stock)
                        }
                        
                        return stocks
                    },
                    flowsModifier: { $0 })
            },
            iterationsModifier: iterationsModifier)
        
        //    static func run(_ flow: Flow<T>) -> Flow<T>
        //    {
        //        Flow(
        //            flow: flow,
        //            fromModifier: fromModifier(flow: flow),
        //            toModifier: toModifier(flow: flow))
        //    }
        //
        //    static func fromModifier(flow: Flow<T>) -> StockModifier
        //    {
        //        { stock in
        //            Stock(stock: stock) { current in
        //                current - flow.amount
        //            }
        //        }
        //    }
        //
        //    static func toModifier(flow: Flow<T>) -> StockModifier
        //    {
        //        { stock in
        //            Stock(stock: stock) { current in
        //                current + flow.amount
        //            }
        //        }
        //    }
    }
    
    static func display(_ world: World)
    {
        print(world.iterations)
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

struct App<T>
{
    typealias Update = (T) -> T
    typealias Display = (T) -> Void
    typealias Exit = (T) -> Bool
    
    func run(
        _ state: T,
        onUpdate update: Update,
        toDisplay display: Display,
        shouldExit: Exit)
    {
        guard !shouldExit(state) else
        {
            print("Goodbye!")
            return
        }
        
        let newState = update(state)
        display(newState)
        
        run(newState,
            onUpdate: update,
            toDisplay: display,
            shouldExit: shouldExit)
    }
}

let stockA = Stock(current: 0, ideal: 100, minimum: 0, maximum: 100)
let stockB = Stock(current: 4, ideal: 100, minimum: 0, maximum: 100)
let flow = Flow(from: stockA, to: stockB, amount: 1)

let app = App<World>()
app.run(
    .init(system: .init(stocks: [], flows: []), iterations: 0),
    onUpdate: World.update,
    toDisplay: World.display,
    shouldExit: World.shouldExit)
