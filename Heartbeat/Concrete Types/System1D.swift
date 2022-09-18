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
    
    // MARK: - Variables
    
    public var stocks: [S]
    public var flows: [F]
    
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
    
    public var leastBalanced: S?
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
    
    public var nextFlow: F?
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
    
    // MARK: - Modifiers
    
    public func update()
    {
        guard let flow = nextFlow else { return }
        let amount = flow.transferAmount
        // These modifications have to come after calculating the flow amount
        flow.from.current -= amount
        flow.to.current += amount
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
