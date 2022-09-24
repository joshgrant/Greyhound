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
    public var rate: Double
    {
        get { _rate() }
        set { _rate = { newValue } }
    }
    
    private var _stockA: StockClosure
    private var _stockB: StockClosure
    private var _rate: ValueClosure
    
    private var pTimeInterval: TimeInterval?
    
    // MARK: - Initialization
    
    public init(
        name: String? = nil,
        unit: Unit,
        stockA: @escaping StockClosure,
        stockB: @escaping StockClosure,
        rate: @escaping ValueClosure)
    {
        self.name = name
        self.unit = unit
        self._stockA = stockA
        self._stockB = stockB
        self._rate = rate
    }
    
    // MARK: - Functions
    
    public func transferAmount(elapsedTime: TimeInterval) -> Double
    {
        let flowAmount = rate * elapsedTime
        
        let transferAmount: Double
        let receiveAmount: Double
        
        if stockA.pressure > stockB.pressure
        {
            transferAmount = stockA.maximumTransferAmount(in: unit)
            receiveAmount = stockB.maximumReceiveAmount(in: unit)
        }
        else
        {
            transferAmount = stockB.maximumTransferAmount(in: unit)
            receiveAmount = stockA.maximumReceiveAmount(in: unit)
        }

        return min(
            flowAmount,
            transferAmount,
            receiveAmount)
    }
    
    public func update(_ timeInterval: TimeInterval)
    {
        let elapsedTime = timeInterval - (pTimeInterval ?? timeInterval)
        let amountToTransfer = transferAmount(elapsedTime: elapsedTime)
        
        if stockA.pressure > stockB.pressure
        {
            stockA.subtract(amount: amountToTransfer, unit: unit)
            stockB.add(amount: amountToTransfer, unit: unit)
        }
        else
        {
            stockA.add(amount: amountToTransfer, unit: unit)
            stockB.subtract(amount: amountToTransfer, unit: unit)
        }
        
        pTimeInterval = timeInterval
    }
}
