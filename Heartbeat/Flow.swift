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
        
        let pressureAInBase = stockA.pressure.valueInBase
        let pressureBInBase = stockB.pressure.valueInBase
        let limitInBase = limit?.valueInBase
        
        if pressureAInBase > pressureBInBase
        {
            _update(
                highPressure: stockA,
                lowPressure: stockB,
                limitInBase: limitInBase,
                elapsedTime: elapsedTime)
        }
        else
        {
            _update(
                highPressure: stockB,
                lowPressure: stockA,
                limitInBase: limitInBase,
                elapsedTime: elapsedTime)
        }
        
        
        pTimeInterval = timeInterval
    }
    
    private func _update(highPressure: Stock<DimensionType>, lowPressure: Stock<DimensionType>, limitInBase: Double?, elapsedTime: TimeInterval)
    {
        let remainingAmount = highPressure.remainingAmount.valueInBase
        let remainingCapacity = lowPressure.remainingCapacity.valueInBase
        
        let limit: Double
        
        if let limitInBase = limitInBase
        {
            limit = min(
                limitInBase * elapsedTime,
                remainingAmount,
                remainingCapacity)
        }
        else
        {
            limit = min(remainingAmount, remainingCapacity)
        }
        
        let amountToRemoveFromHighPressure = Measurement(value: limit, unit: highPressure.unit)
        let amountToAddToLowPressure = Measurement(value: limit, unit: lowPressure.unit)
        
        highPressure.current -= amountToRemoveFromHighPressure
        lowPressure.current += amountToAddToLowPressure
    }
}
