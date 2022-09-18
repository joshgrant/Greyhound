//
//  System.swift
//  Client
//
//  Created by Joshua Grant on 9/16/22.
//

import Foundation
import Spatial

class System<T: Primitive3D>
{
    typealias StocksModifier = ([Stock<T>]) -> [Stock<T>]
    typealias FlowsModifier = ([Flow<T>]) -> [Flow<T>]
    
    // MARK: - Variables
    
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
    
    var leastBalanced: Stock<T>?
    {
        var balance: T = .infinity
        var stock: Stock<T>?
        
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
    
    var nextFlow: Flow<T>?
    {
        guard let leastBalanced = leastBalanced else { return nil }
        
        return flows.first { flow in
            switch leastBalanced.sign
            {
            case .positive:
                return flow.from === leastBalanced
            case .negative:
                return flow.to === leastBalanced
            case .neither:
                return false
            }
        }
    }
    
    // MARK: - Initialization
    
    init(stocks: [Stock<T>], flows: [Flow<T>])
    {
        self.stocks = stocks
        self.flows = flows
    }
    
    convenience init(
        system: System<T>,
        stocks: [Stock<T>]? = nil,
        flows: [Flow<T>]? = nil)
    {
        self.init(
            stocks: stocks ?? system.stocks,
            flows: flows ?? system.flows)
    }
    
    convenience init(
        system: System<T>,
        stocksModifier: StocksModifier? = nil,
        flowsModifier: FlowsModifier? = nil)
    {
        self.init(
            system: system,
            stocks: stocksModifier?(system.stocks) ?? system.stocks,
            flows: flowsModifier?(system.flows) ?? system.flows)
    }
    
    // MARK: - Modifiers
    
    static func modifier(system: System<T>) -> System<T>
    {
        guard let flow = system.nextFlow else { return system }
        
        flow.from.current -= flow.amount
        flow.to.current += flow.amount
        
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
