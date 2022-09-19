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
    
    public var balance: Double?
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
    
    public var leastBalanced: Stock?
    {
        var balance = Double.infinity
        var stock: Stock?
        
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
    
    public var nextFlow: Flow?
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
    
    public init(stocks: [Stock], flows: [Flow])
    {
        self.stocks = stocks
        self.flows = flows
    }
    
    // MARK: - Modifiers
    
    public func update(_ timeInterval: TimeInterval)
    {
        for flow in flows
        {
            flow.update(timeInterval)
        }
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
