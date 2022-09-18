//
//  System1D.swift
//  Heartbeat
//
//  Created by Joshua Grant on 9/18/22.
//

import Foundation

class System1D: System
{
    typealias S = Stock1D
    typealias F = Flow1D
    
    typealias StocksModifier = ([S]) -> [S]
    typealias FlowsModifier = ([F]) -> [F]
    
    // MARK: - Variables
    
    var stocks: [S]
    var flows: [F]
    
    var balance: Double?
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
    
    var leastBalanced: S?
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
    
    var nextFlow: F?
    {
        guard let leastBalanced = leastBalanced else { return nil }

        return flows.first { flow in
            switch leastBalanced.sign
            {
            case .positive:
                return flow.from == leastBalanced
            case .negative:
                return flow.to == leastBalanced
            case .neither:
                return false
            }
        }
    }
    
    // MARK: - Initialization
    
    init(stocks: [S], flows: [F])
    {
        self.stocks = stocks
        self.flows = flows
    }
    
    convenience init(
        system: System1D,
        stocks: [S]? = nil,
        flows: [F]? = nil)
    {
        self.init(
            stocks: stocks ?? system.stocks,
            flows: flows ?? system.flows)
    }
    
    convenience init(
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
    
    static func modifier(system: System1D) -> System1D
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
