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
    public let unit: Unit
    public var stockA: Stock { _stockA() }
    public var stockB: Stock { _stockB() }
    
    /// Units/second
    public var limit: Double
    {
        get { _limit() }
        set { _limit = { newValue } }
    }
    
    private var _stockA: StockClosure
    private var _stockB: StockClosure
    private var _limit: ValueClosure
    
    private var pTimeInterval: TimeInterval?
    
    // MARK: - Initialization
    
    public init(
        name: String? = nil,
        unit: Unit,
        stockA: @escaping StockClosure,
        stockB: @escaping StockClosure,
        limit: @escaping ValueClosure)
    {
        self.name = name
        self.unit = unit
        self._stockA = stockA
        self._stockB = stockB
        self._limit = limit
    }
    
    // MARK: - Functions
    
    public func transferAmount(elapsedTime: TimeInterval) -> Double
    {
//        let flowAmount = rate * elapsedTime
//
//        let transferAmount: Double
//        let receiveAmount: Double
//
//        if stockA.pressure > stockB.pressure
//        {
//            transferAmount = stockA.maximumTransferAmount(in: unit)
//            receiveAmount = stockB.maximumReceiveAmount(in: unit)
//        }
//        else
//        {
//            transferAmount = stockB.maximumTransferAmount(in: unit)
//            receiveAmount = stockA.maximumReceiveAmount(in: unit)
//        }
//
//        return min(
//            flowAmount,
//            transferAmount,
//            receiveAmount)
        return 0
    }
    
    public func update(_ timeInterval: TimeInterval)
    {
        let elapsedTime = timeInterval - (pTimeInterval ?? timeInterval)
        
        let amountA = unit
            .dimension
            .baseUnit
            .convert(
                value: stockA.pressure,
                to: stockA.unit)
        
        let amountB = unit
            .dimension
            .baseUnit
            .convert(
                value: stockB.pressure,
                to: stockB.unit)
        
        let totalLimit = limit * elapsedTime
        let mint = min(
            abs(amountA),
            abs(amountB),
            totalLimit)
        let signA: Double = amountA < 0 ? -1 : 1 // Flips signs?
        let signB: Double = amountB < 0 ? -1 : 1 // Flips signs?
        let plusA = mint * signA
        let plusB = mint * signB
        
        print(amountA, amountB, mint, plusA, plusB)
        
        // AmountA needs to be constrained to the limit of the stock
        // AmountB needs to be constrainted to the limit of the stock
        
        stockA.current -= plusA
        stockB.current -= plusB

        
        pTimeInterval = timeInterval
    }
}

//fileprivate extension Stock
//{
//    // Returns the remainder trying to add the given amount
//    func add(amount: Double) -> Double
//    {
//        let remainder = min(0, maximum - (current + amount))
//        current += amount - remainder
//        return remainder
//    }
//}
