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
    public let unit: Unit<DimensionType>
    public var limit: Double?
    public var stockA: Stock<DimensionType>
    public var stockB: Stock<DimensionType>
    // Limit in base?
    
    private var pTimeInterval: TimeInterval?
    
    // MARK: - Initialization
    
    public init(
        name: String? = nil,
        unit: Unit<DimensionType>,
        limit: Double?,
        stockA: Stock<DimensionType>,
        stockB: Stock<DimensionType>)
    {
        self.name = name
        self.unit = unit
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
        
        pTimeInterval = timeInterval
    }
}
