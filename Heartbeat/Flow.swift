//
//  Flow.swift
//  Heartbeart
//
//  Created by Joshua Grant on 9/16/22.
//

import Foundation

public protocol FlowType
{
    associatedtype DimensionType: Dimension
    
    var stockA: Stock<DimensionType> { get }
    var stockB: Stock<DimensionType> { get }
    
    func update(_ timeInterval: TimeInterval)
}

open class Flow<DimensionType: Dimension>
{
    // MARK: - Functions
    
    public let name: String?
    public var limit: Measurement<DimensionType>?
    public var stockA: Stock<DimensionType>
    public var stockB: Stock<DimensionType>
    
    private var pTimeInterval: TimeInterval?
    
    // MARK: - Initialization
    
    public init(
        name: String? = nil,
        limit: Measurement<DimensionType>?,
        stockA: Stock<DimensionType>,
        stockB: Stock<DimensionType>)
    {
        self.name = name
        self.limit = limit
        self.stockA = stockA
        self.stockB = stockB
    }
    
    // MARK: - Functions
    
    public func update(_ timeInterval: TimeInterval)
    {
        let elapsedTime = timeInterval - (pTimeInterval ?? timeInterval)
        
        // Find the stock with the most pressure
        // Find the limiting factor (stock capacity, flow limit)
        // Transfer the stock amounts
        
        let pressureAInBase = stockA.pressure.valueInBase
        let pressureBInBase = stockB.pressure.valueInBase
        let limitInBase = limit?.valueInBase
        
        /*
         The direction is from high pressure to low pressure
         So we just need to get the sign of flow
         
         Then, we need to figure out the limit, depending on the direction of flow
         
         So the low pressure system's limit is 0
         And the high pressure system's limit is the max
         
         How can we do this? Can we do it without it statements?
         */
        
        if pressureAInBase > pressureBInBase
        {
            let remainingAmount = stockA.remainingAmount.valueInBase
            let remainingCapacity = stockB.remainingCapacity.valueInBase
            
            let limit: Double
            
            if let limitInBase = limitInBase
            {
                limit = min(limitInBase, remainingAmount, remainingCapacity)
            }
            else
            {
                limit = min(remainingAmount, remainingCapacity)
            }
            
            let amountToRemoveFromStockA = Measurement(value: limit, unit: stockA.unit)
            let amountToAddToStockB = Measurement(value: limit, unit: stockB.unit)
            
            stockA.current -= amountToRemoveFromStockA
            stockB.current += amountToAddToStockB
        }
        else
        {
            
        }
        
        
        pTimeInterval = timeInterval
    }
}
