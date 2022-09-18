//
//  Flow.swift
//  Client
//
//  Created by Joshua Grant on 9/16/22.
//

import Foundation
import Spatial

protocol Flow: AnyObject, CustomStringConvertible, Equatable
{
    associatedtype Stock
    
    var from: Stock { get set }
    var to: Stock { get set }
    
    var amount: Double { get set }
    var duration: TimeInterval { get set }
}

class Flow1D: Flow
{
    typealias StockModifier = (Stock1D) -> Stock1D
    
    // MARK: - Variables
    
    var from: Stock1D
    var to: Stock1D
    
    var amount: Double
    var duration: TimeInterval
    
    // MARK: - Initialization
    
    init(from: Stock1D, to: Stock1D, amount: Double, duration: TimeInterval)
    {
        self.from = from
        self.to = to
        self.amount = amount
        self.duration = duration
    }
    
    convenience init(
        flow: Flow1D,
        from: Stock1D? = nil,
        to: Stock1D? = nil,
        amount: Double? = nil,
        duration: TimeInterval? = nil)
    {
        self.init(
            from: from ?? flow.from,
            to: to ?? flow.to,
            amount: amount ?? flow.amount,
            duration: duration ?? flow.duration)
    }
    
    convenience init(
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

extension Flow1D: Equatable
{
    static func ==(lhs: Flow1D, rhs: Flow1D) -> Bool
    {
        lhs === rhs
    }
}

extension Flow1D: CustomStringConvertible
{
    var description: String
    {
        "Amount: \(amount)"
    }
}
