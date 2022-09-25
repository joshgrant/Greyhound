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
    // Limit in base?
    
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
        
        pTimeInterval = timeInterval
    }
}
