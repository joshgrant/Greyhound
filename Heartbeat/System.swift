//
//  System.swift
//  Client
//
//  Created by Joshua Grant on 9/16/22.
//

import Foundation
import Numerics

class System
{
    typealias StocksModifier = ([any Stock]) -> [any Stock]
    typealias FlowsModifier = ([any Flow]) -> [any Flow]
    
    // MARK: - Variables
    
    var stocks: [any Stock]
    var flows: [any Flow]
    
    var balance: Double?
    {
        var total = Double.zero
        var ideal = Double.zero
        
        for stock in stocks
        {
            total += stock.balance
            ideal += 1
        }
        
        if ideal == 0 { return 1 }
        return total / ideal
    }
    
    var leastBalanced: (any Stock)?
    {
        var balance = Double.infinity
        var stock: (any Stock)?
        
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
    
    var nextFlow: (any Flow)?
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
    
    init(stocks: [any Stock], flows: [any Flow])
    {
        self.stocks = stocks
        self.flows = flows
    }
    
    convenience init(
        system: System,
        stocks: [any Stock]? = nil,
        flows: [any Flow]? = nil)
    {
        self.init(
            stocks: stocks ?? system.stocks,
            flows: flows ?? system.flows)
    }
    
    convenience init(
        system: System,
        stocksModifier: StocksModifier? = nil,
        flowsModifier: FlowsModifier? = nil)
    {
        self.init(
            system: system,
            stocks: stocksModifier?(system.stocks) ?? system.stocks,
            flows: flowsModifier?(system.flows) ?? system.flows)
    }
    
    // MARK: - Modifiers
    
    static func modifier(system: System) -> System
    {
        guard let flow = system.nextFlow else { return system }
        
        if let from = flow.from as? any Stock, let to = flow.to as? any Stock
        {
            from.remove(amount: flow.amount)
            to.add(amount: flow.amount)
        }
        else
        {
            fatalError("Failed to unwrap the flow's stocks.")
        }
        
        return system
    }
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
