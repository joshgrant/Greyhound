//
//  System1D.swift
//  Heartbeat
//
//  Created by Joshua Grant on 9/18/22.
//

import Foundation

open class System
{
    // MARK: - Variables
    
    public var stocks: [Stock]
    public var flows: [Flow]
    public var subsystems: [System] = []
    
    public var balance: Double?
    {
        var total: Double = 0
        var ideal: Double = 0
        
        for stock in stocks
        {
            if let b = stock.balance
            {
                total += b
                ideal += 1
            }
        }
        
        if ideal == 0 { return 1 }
        return total / ideal
    }
    
    public var leastBalanced: Stock?
    {
        var balance = Double.infinity
        var stock: Stock?
        
        for s in stocks
        {
            if let b = s.balance, b < balance
            {
                balance = b
                stock = s
            }
        }
        
        return stock
    }
    
    public var allUnbalanced: [Stock]
    {
        stocks
            .filter {
                guard let balance = $0.balance else { return false }
                return balance < 1
            }
            .sorted {
                guard let b0 = $0.balance, let b1 = $1.balance else { return false }
                return b0 > b1
            }
    }
    
    // MARK: - Initialization
    
    public init(stocks: [Stock], flows: [Flow], subsystems: [System] = [])
    {
        self.stocks = stocks
        self.flows = flows
        self.subsystems = subsystems
    }
    
    // MARK: - Modifiers
    
    // TODO: Implement cost
    public func update(_ timeInterval: TimeInterval)
    {
        var flowsToRun: [Flow] = []
        
        for stock in allUnbalanced
        {
            let sign = stock.sign
            
            let flow = flows.first(where: { flow in
                switch sign
                {
                case .orderedAscending: // Current greater than ideal
                    return flow.from == stock
                case .orderedDescending: // Current less than ideal
                    return flow.to == stock
                case .orderedSame:
                    return false
                case .none:
                    return false
                }
            })
            
            if let flow = flow
            {
                flowsToRun.append(flow)
            }
        }
        
        for flow in flowsToRun
        {
            flow.update(timeInterval)
        }
        
        // Now update all of the systems
        
        subsystems.forEach { $0.update(timeInterval) }
    }
}

extension System: CustomStringConvertible
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

extension Array where Element: Flow
{
    public subscript(_ name: String) -> Flow?
    {
        first { $0.name == name }
    }
}

extension Array where Element: Stock
{
    public subscript(_ name: String) -> Stock?
    {
        first { $0.name == name }
    }
}
