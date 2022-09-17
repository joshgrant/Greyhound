//
//  System.swift
//  Client
//
//  Created by Joshua Grant on 9/16/22.
//

import Foundation

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
    
    init(system: System<T>, stocks: [Stock<T>]? = nil, flows: [Flow<T>]? = nil)
    {
        self.init(
            stocks: stocks ?? system.stocks,
            flows: flows ?? system.flows)
    }
    
    init(system: System<T>, stocksModifier: StocksModifier? = nil, flowsModifier: FlowsModifier? = nil)
    {
        self.init(
            system: system,
            stocks: stocksModifier?(system.stocks) ?? system.stocks,
            flows: flowsModifier?(system.flows) ?? system.flows)
    }
    
    // MARK: - Modifiers
    
    static func modifier(system: System<T>) -> System<T>
    {
        print("BEFORE: \(system)")
        var system = system
        for flow in system.flows
        {
            system = System.run(flow: flow, system: system)
        }
        print("AFTER: \(system)")
        print("-----")
        return system
    }
    
    static func run(flow: Flow<T>, system: System<T>) -> System<T>
    {
        System<T>(
            system: system,
            stocksModifier: stocksModifier(flow))
    }
    
    static func stocksModifier(_ flow: Flow<T>) -> StocksModifier
    {
        { stocks in
            stocks.map { stock in
                if flow.from == stock
                {
                    return Stock(stock: stock) { current in
                        current - flow.amount
                    }
                }
                else if flow.to == stock
                {
                    return Stock(stock: stock) { current in
                        current + flow.amount
                    }
                }
                else
                {
                    return stock
                }
            }
        }
    }
}

extension System: Equatable
{
    
}

extension System: CustomStringConvertible
{
    var description: String
    {
"""
Flows:
-----
\(flows.map { $0.description })
Stocks:
------
\(stocks.map { $0.description })
"""
    }
}
