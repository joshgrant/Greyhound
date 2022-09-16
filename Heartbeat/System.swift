//
//  System.swift
//  Heartbeat
//
//  Created by Joshua Grant on 9/15/22.
//

import Foundation
import Numerics

public class System<T: Real & Codable>: Copyable
{
    // MARK: - Variables
    
    var uuid = UUID()
    
    var stocks: [Stock<T>]
    var flows: [Flow<T>]
    
    // MARK: - Initialization
    
    init()
    {
        self.stocks = []
        self.flows = []
    }
    
    required init(stocks: [Stock<T>], flows: [Flow<T>])
    {
        self.stocks = stocks
        self.flows = flows
    }
    
    // MARK: - Copyable
    
    enum CodingKeys: CodingKey
    {
        case stocks
        case flows
    }
    
    public required init(from decoder: Decoder) throws
    {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        stocks = try container.decode([Stock<T>].self, forKey: .stocks)
        flows = try container.decode([Flow<T>].self, forKey: .flows)
    }
    
    public func encode(to encoder: Encoder) throws
    {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(stocks, forKey: .stocks)
        try container.encode(flows, forKey: .flows)
    }
}

extension System
{
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
    
    @available(*, deprecated)
    var leastBalanced: Stock<T>?
    {
        var stock: Stock<T>?
        var balance = T.infinity
        
        for s in stocks
        {
            let b = s.balance
            
            if b < balance {
                balance = b
                stock = s
            }
        }
        
        return stock
    }
    
    var nextFlow: Flow<T>?
    {   
        guard let copy = self.deepCopy() else { fatalError() }
        
        print("EQUALS")
        print(copy == self)
        
        var bestBalance: T = balance
        var bestFlow: Flow<T>?
        
        for flow in copy.flows
        {
            print("BEFORE")
            print(flow.from.balance)
            print(flow.to.balance)
            print(copy.balance)
            
            flow.run()
            
            print("AFTER")
            print(flow.from.balance)
            print(flow.to.balance)
            // Somehow the flow.from loses track of the same stock that copy is referencing...
            // So... getting the balance never updates...
            // We need a better way of doing this
            print(copy.balance)
            print("-----")
            
            if copy.balance > bestBalance
            {
                bestBalance = copy.balance
                bestFlow = flow
            }
        }

        return bestFlow
    }
}

extension System: Equatable
{
    public static func == (lhs: System<T>, rhs: System<T>) -> Bool
    {
        lhs.uuid == rhs.uuid
    }
}
