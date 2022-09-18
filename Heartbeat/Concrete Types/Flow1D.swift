//
//  Flow.swift
//  Client
//
//  Created by Joshua Grant on 9/16/22.
//

import Foundation

open class Flow1D: Flow
{
    public typealias StockModifier = (Stock1D) -> Stock1D
    
    // MARK: - Variables
    
    public var name: String
    
    public var from: Stock1D
    public var to: Stock1D
    
    public var amount: Double
    public var duration: TimeInterval
    
    // MARK: - Initialization
    
    public init(name: String, from: Stock1D, to: Stock1D, amount: Double, duration: TimeInterval)
    {
        self.name = name
        self.from = from
        self.to = to
        self.amount = amount
        self.duration = duration
    }
    
    public convenience init(
        flow: Flow1D,
        name: String? = nil,
        from: Stock1D? = nil,
        to: Stock1D? = nil,
        amount: Double? = nil,
        duration: TimeInterval? = nil)
    {
        self.init(
            name: name ?? flow.name,
            from: from ?? flow.from,
            to: to ?? flow.to,
            amount: amount ?? flow.amount,
            duration: duration ?? flow.duration)
    }
    
    public convenience init(
        flow: Flow1D,
        fromModifier: StockModifier,
        toModifier: StockModifier,
        amount: Double? = nil)
    {
        self.init(
            flow: flow,
            from: fromModifier(flow.from),
            to: toModifier(flow.to),
            amount: amount)
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
