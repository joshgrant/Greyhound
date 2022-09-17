//
//  Flow.swift
//  Client
//
//  Created by Joshua Grant on 9/16/22.
//

import Foundation

class Flow<T: FloatingPoint>
{
    typealias StockModifier = (Stock<T>) -> Stock<T>
    
    // MARK: - Variables
    
    var uuid: UUID
    
    var from: Stock<T>
    var to: Stock<T>
    
    var amount: T
    
    // MARK: - Initialization
    
    init(from: Stock<T>, to: Stock<T>, amount: T, uuid: UUID = UUID())
    {
        precondition(amount > 0)
        
        self.from = from
        self.to = to
        self.amount = amount
        self.uuid = uuid
    }
    
    convenience init(
        flow: Flow,
        from: Stock<T>? = nil,
        to: Stock<T>? = nil,
        amount: T? = nil,
        uuid: UUID? = nil)
    {
        self.init(
            from: from ?? flow.from,
            to: to ?? flow.to,
            amount: amount ?? flow.amount,
            uuid: uuid ?? flow.uuid)
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

extension Flow: Equatable
{
    static func == (lhs: Flow<T>, rhs: Flow<T>) -> Bool
    {
        lhs.uuid == rhs.uuid
    }
}

extension Flow: CustomStringConvertible
{
    var description: String
    {
        "Amount: \(amount)"
    }
}
