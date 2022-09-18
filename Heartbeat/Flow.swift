//
//  Flow.swift
//  Client
//
//  Created by Joshua Grant on 9/16/22.
//

import Foundation
import Spatial

class Flow<T: Primitive3D>
{
    typealias StockModifier = (Stock<T>) -> Stock<T>
    
    // MARK: - Variables
    
    var from: Stock<T>
    var to: Stock<T>
    
    var amount: T
    var duration: TimeInterval
    
    // MARK: - Initialization
    
    init(from: Stock<T>, to: Stock<T>, amount: T, duration: TimeInterval)
    {
        precondition(amount > .zero)
        
        self.from = from
        self.to = to
        self.amount = amount
        self.duration = duration
    }
    
    convenience init(
        flow: Flow,
        from: Stock<T>? = nil,
        to: Stock<T>? = nil,
        amount: T? = nil,
        duration: TimeInterval? = nil)
    {
        self.init(
            from: from ?? flow.from,
            to: to ?? flow.to,
            amount: amount ?? flow.amount,
            duration: duration ?? flow.duration)
    }
    
    convenience init(
        flow: Flow,
        fromModifier: StockModifier,
        toModifier: StockModifier,
        amount: T? = nil)
    {
        self.init(
            flow: flow,
            from: fromModifier(flow.from),
            to: toModifier(flow.to),
            amount: amount)
    }
}

extension Flow: CustomStringConvertible
{
    var description: String
    {
        "Amount: \(amount)"
    }
}
