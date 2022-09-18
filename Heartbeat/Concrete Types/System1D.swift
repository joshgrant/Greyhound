//
//  System1D.swift
//  Heartbeat
//
//  Created by Joshua Grant on 9/18/22.
//

import Foundation

open class System1D: System
{
    public typealias S = Stock1D
    public typealias F = Flow1D
    
    public typealias StocksModifier = ([S]) -> [S]
    public typealias FlowsModifier = ([F]) -> [F]
    
    // MARK: - Variables
    
    var stocks: [S]
    var flows: [F]
    
    private var balance: Double?
    {
        var total: Double = 0
        var ideal: Double = 0
        
        for stock in stocks
        {
            total += stock.balance
            ideal += 1
        }
        
        if ideal == 0 { return 1 }
        return total / ideal
    }
    
    private var leastBalanced: S?
    {
        var balance = Double.infinity
        var stock: S?
        
        for s in stocks
        {
            if s.balance < balance
            {
                balance = s.balance
                stock = s
            }
        }
        
        return stock
    }
    
    private var nextFlow: F?
    {
        guard let leastBalanced = leastBalanced else { return nil }

        return flows.first { flow in
            switch leastBalanced.sign
            {
            case .orderedAscending:
                return flow.from == leastBalanced
            case .orderedDescending:
                return flow.to == leastBalanced
            case .orderedSame:
                return false
            }
        }
    }
    
    // MARK: - Initialization
    
    public init(stocks: [S], flows: [F])
    {
        self.stocks = stocks
        self.flows = flows
    }
    
    public convenience init(
        system: System1D,
        stocks: [S]? = nil,
        flows: [F]? = nil)
    {
        self.init(
            stocks: stocks ?? system.stocks,
            flows: flows ?? system.flows)
    }
    
    public convenience init(
        system: System1D,
        stocksModifier: StocksModifier? = nil,
        flowsModifier: FlowsModifier? = nil)
    {
        self.init(
            system: system,
            stocks: stocksModifier?(system.stocks) ?? system.stocks,
            flows: flowsModifier?(system.flows) ?? system.flows)
    }
    
    // MARK: - Modifiers
    
    private static func modifier(system: System1D) -> System1D
    {
        guard let flow = system.nextFlow else { return system }
        
        // TODO: Write a unit test for this...
        let amount = min(flow.amount, flow.to.max - flow.from.current, flow.from.current - flow.from.min)
        flow.from.current -= amount
        flow.to.current += amount
        
        return system
    }
}

extension System1D: CustomStringConvertible
{
    public var description: String
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
