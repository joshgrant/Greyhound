//
//  Flow.swift
//  Client
//
//  Created by Joshua Grant on 9/16/22.
//

import Foundation

open class Flow
{
    // MARK: - Variables
    
    public var name: String
    
    public var from: Stock
    public var to: Stock
    
    public var amount: Double
    public var duration: TimeInterval
    
    private var lastTimeInterval: TimeInterval?
    
    public var transferAmount: Double
    {
        min(amount,
            abs(to.max - to.current),
            abs(from.current - from.min))
    }
    
    // MARK: - Initialization
    
    public init(name: String, from: Stock, to: Stock, amount: Double, duration: TimeInterval)
    {
        self.name = name
        self.from = from
        self.to = to
        self.amount = amount
        self.duration = duration
    }
    
    // MARK: - Functions
    
    public func update(_ timeInterval: TimeInterval)
    {
        if let last = lastTimeInterval
        {
            if timeInterval - last > duration
            {
                let amount = transferAmount
                // These modifications have to come after calculating the flow amount
                from.current -= amount
                to.current += amount
                
                lastTimeInterval = timeInterval
            }
        }
        else
        {
            lastTimeInterval = timeInterval
        }
    }
}

extension Flow: CustomStringConvertible
{
    public var description: String
    {
        "Flow \(name): \(amount)"
    }
}

extension Flow: Equatable
{
    public static func ==(lhs: Flow, rhs: Flow) -> Bool
    {
        lhs === rhs
    }
}
