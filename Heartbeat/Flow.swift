//
//  Flow.swift
//  Client
//
//  Created by Joshua Grant on 9/16/22.
//

import Foundation

open class Flow
{
    // MARK: - Defined types
    
    public typealias StockClosure = () -> Stock
    public typealias ValueClosure = () -> Double
    
    // MARK: - Variables
    
    public var name: String? = nil
    
    private var _from: StockClosure
    private var _to: StockClosure
    private var _amount: ValueClosure
    private var _duration: ValueClosure
    
    public var from: Stock { _from() }
    public var to: Stock { _to() }
    public var amount: Double { _amount() }
    public var duration: Double { _duration() }
    
    private var lastFireDate: TimeInterval?
    
    public var transferAmount: Double
    {
        min(amount, 100)
    }
    
    // MARK: - Initialization
    
    init(
        name: String? = nil,
        from: @escaping StockClosure,
        to: @escaping StockClosure,
        amount: @escaping ValueClosure,
        duration: @escaping ValueClosure)
    {
        self.name = name
        self._from = from
        self._to = to
        self._amount = amount
        self._duration = duration
    }
}
//
//open class Flow
//{
//    // MARK: - Variables
//    
//    public var name: String?
//    
//    public var from: Stock?
//    public var to: Stock?
//    
//    public var amount: Double
//    public var duration: TimeInterval
//    
//    private var lastTimeInterval: TimeInterval?
//    
//    public var transferAmount: Double
//    {
//        guard let from = from, let to = to else { return 0 }
//        
//        return min(amount,
//                   abs(to.max - to.current),
//                   abs(from.current - from.min))
//    }
//    
//    // MARK: - Initialization
//    
//    public init(name: String? = nil, from: Stock?, to: Stock?, amount: Double, duration: TimeInterval)
//    {
//        self.name = name
//        self.from = from
//        self.to = to
//        self.amount = amount
//        self.duration = duration
//    }
//    
//    // MARK: - Functions
//    
//    public func update(_ timeInterval: TimeInterval)
//    {
//        guard let from = from, let to = to else { return }
//        
//        if let last = lastTimeInterval
//        {
//            if timeInterval - last > duration
//            {
//                let amount = transferAmount
//                // These modifications have to come after calculating the flow amount
//                from.current -= amount
//                to.current += amount
//                
//                lastTimeInterval = timeInterval
//            }
//        }
//        else
//        {
//            lastTimeInterval = timeInterval
//        }
//    }
//}
//
//extension Flow: CustomStringConvertible
//{
//    public var description: String
//    {
//        "Flow \(name ?? ""): \(amount)"
//    }
//}
//
//extension Flow: Equatable
//{
//    public static func ==(lhs: Flow, rhs: Flow) -> Bool
//    {
//        lhs === rhs
//    }
//}
