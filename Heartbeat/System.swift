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
    
    public var stocks: [Stock]
    public var flows: [Flow]
    
    // MARK: - Initialization
    
    public init(
        stocks: [Stock]? = nil,
        flows: [Flow]? = nil)
    {
        self.stocks = stocks ?? []
        self.flows = flows ?? []
    }
    
    // MARK: - Functions
    
    public func update(_ timeInterval: TimeInterval)
    {
        flows.forEach { $0.update(timeInterval) }
    }
    
    func stocksTotalCurrent() -> Double
    {
        stocks.reduce(0) { $0 + $1.current }
    }
    
    func stocksTotalDelta() -> Double
    {
        stocks.reduce(0) { $0 + $1.delta }
    }
    
    func stocksTotalMaximum() -> Double
    {
        stocks.reduce(0) { $0 + $1.maximum }
    }
    
    func stocksTotalIdeal() -> Double
    {
        stocks.reduce(0) { $0 + $1.ideal }
    }
    
    public var balance: Double
    {
        guard stocks.count > 0 else { return 1 }
        let delta = stocksTotalDelta()
        let maximum = stocksTotalMaximum()
        return 1 - abs(delta) / maximum
    }
    
    public func convertToStock() -> Stock
    {
        Stock(
            unit: .system,
            current: stocksTotalCurrent,
            maximum: stocksTotalMaximum,
            ideal: stocksTotalIdeal)
    }
}
