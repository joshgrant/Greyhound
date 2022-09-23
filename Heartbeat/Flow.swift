//
//  Flow.swift
//  Client
//
//  Created by Joshua Grant on 9/16/22.
//

import Foundation

public enum FlowError: Error
{
    case incompatibleDimensions(_ a: Dimension, _ b: Dimension)
}

open class Flow
{
    // MARK: - Defined types
    
    public typealias StockClosure = () -> Stock
    public typealias ValueClosure = () -> Double
    
    // MARK: - Variables
    
    public var name: String? = nil

    public let unit: Unit
    
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
        // TODO: This transfer amount is not based on the Dimension
        //
        
        min(rate * elapsedTime,
            from.maximumTransferAmount,
            to.maximumReceiveAmount)
    }
    
    // MARK: - Initialization
    
    public init(
        name: String? = nil,
        unit: Unit,
        from: @escaping StockClosure,
        to: @escaping StockClosure,
        rate: @escaping ValueClosure) throws
    {
        guard unit.canConvert(to: from().unit) else
        {
            throw FlowError.incompatibleDimensions(
                unit.dimension,
                from().unit.dimension)
        }
        
        guard unit.canConvert(to: to().unit) else
        {
            throw FlowError.incompatibleDimensions(
                unit.dimension,
                to().unit.dimension)
        }
        
        self.name = name
        self.unit = unit
        self._from = from
        self._to = to
        self._rate = rate
    }
    
    public func update(_ timeInterval: TimeInterval)
    {
        let elapsedTime = timeInterval - (pTimeInterval ?? timeInterval)
        let amountToTransfer = transferAmount(elapsedTime: elapsedTime)
        
        from.current -= amountToTransfer
        to.current += amountToTransfer
        
        pTimeInterval = timeInterval
    }
}
