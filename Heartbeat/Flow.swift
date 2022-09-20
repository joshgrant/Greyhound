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
        min(amount, from.maximumTransferAmount, to.maximumReceiveAmount)
    }
    
    // MARK: - Initialization
    
    public init(
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
    
    public func update(_ timeInterval: TimeInterval)
    {
        // In the case where lastFireDate is nil,
        // we should set it to a value so that we
        // can start calculating the time delta
        guard let lastFireDate = lastFireDate else
        {
            lastFireDate = timeInterval
            return
        }
        
        let delta = timeInterval - lastFireDate
        
        if delta >= duration
        {
            let amount = transferAmount
            from.current -= amount
            to.current += amount
            
            self.lastFireDate = timeInterval
        }
    }
}

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
