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
    
    public var from: Stock { _from() }
    public var to: Stock { _to() }
    
    /// Units/second
    public var rate: Double
    {
        get { _rate() }
        set { _rate = { newValue } }
    }
    
    private var _from: StockClosure
    private var _to: StockClosure
    private var _rate: ValueClosure
    
    private var pTimeInterval: TimeInterval?
    
    public func transferAmount(elapsedTime: TimeInterval) -> Double
    {        
        min(rate * elapsedTime,
            from.maximumTransferAmount,
            to.maximumReceiveAmount)
    }
    
    // MARK: - Initialization
    
    public init(
        name: String? = nil,
        from: @escaping StockClosure,
        to: @escaping StockClosure,
        rate: @escaping ValueClosure)
    {
        self.name = name
        self._from = from
        self._to = to
        self._rate = rate
    }
    
    public func update(_ timeInterval: TimeInterval)
    {
        let elapsedTime = timeInterval - (pTimeInterval ?? timeInterval)
        let amountToTransfer = transferAmount(elapsedTime: elapsedTime)
        
        from.current -= amountToTransfer // Based on the ratio to the flow Dimension
        to.current += amountToTransfer // Based on the ratio to the flow Dimension
        
        // Can a flow change dimensinons?
        // No, because then the stocks wouldn't work...
        
        print(amountToTransfer)
        
        pTimeInterval = timeInterval
    }
}
