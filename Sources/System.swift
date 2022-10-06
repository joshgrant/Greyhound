//
//  System.swift
//  Heartbeat
//
//  Created by Joshua Grant on 9/18/22.
//

import Foundation

open class System
{
    // MARK: - Variables
    
    public var stocks: [any StockType]
    public var flows: [any FlowType]
    
    public var pressure: Double { 0 }
    
    // MARK: - Initialization
    
    public init(
        stocks: [any StockType]? = nil,
        flows: [any FlowType]? = nil)
    {
        self.stocks = stocks ?? []
        self.flows = flows ?? []
    }
    
    // MARK: - Functions
    
    public func update(_ timeInterval: TimeInterval)
    {
        flows.forEach { $0.update(timeInterval) }
    }
}
