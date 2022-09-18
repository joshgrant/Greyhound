//
//  Flow.swift
//  Client
//
//  Created by Joshua Grant on 9/16/22.
//

import Foundation

open class Flow1D: Flow
{
    // MARK: - Variables
    
    public var name: String
    
    public var from: Stock1D
    public var to: Stock1D
    
    public var amount: Double
    public var duration: TimeInterval
    
    public var transferAmount: Double
    {
        min(amount,
            abs(to.max - to.current),
            abs(from.current - from.min))
    }
    
    // MARK: - Initialization
    
    public init(name: String, from: Stock1D, to: Stock1D, amount: Double, duration: TimeInterval)
    {
        self.name = name
        self.from = from
        self.to = to
        self.amount = amount
        self.duration = duration
    }
}

extension Flow1D: CustomStringConvertible
{
    public var description: String
    {
        "Flow \(name): \(amount)"
    }
}

extension Flow1D: Equatable
{
    public static func ==(lhs: Flow1D, rhs: Flow1D) -> Bool
    {
        lhs === rhs
    }
}
