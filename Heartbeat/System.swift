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
    
    func stocksTotalPressure() -> Double
    {
        stocks.reduce(0) { $0 + $1.pressure }
    }
    
    func stocksTotalMaximum() -> Double?
    {
        stocks.compactMap { $0.maximum }.reduce(0, +)
    }
    
    func stocksTotalIdeal() -> Double
    {
        stocks.reduce(0) { $0 + $1.ideal }
    }
    
    public var pressure: Double
    {
        guard stocks.count > 0 else { return 0 }
        let current = stocksTotalCurrent()
        let ideal = stocksTotalIdeal()
        if let maximum = stocksTotalMaximum()
        {
            return current - min(ideal, maximum)
        }
        else
        {
            return current - ideal
        }
    }
    
    public func convertToStock() -> Stock
    {
        var maximumClosure: Stock.ValueClosure?
        
        if let totalMaximum = stocksTotalMaximum()
        {
            maximumClosure = { totalMaximum }
        }
        
        return Stock(
            unit: .system,
            current: stocksTotalCurrent,
            maximum: maximumClosure,
            ideal: stocksTotalIdeal)
    }
}
