//
//  Stock.swift
//  Client
//
//  Created by Joshua Grant on 9/16/22.
//

import Foundation

open class Stock1D: Stock
{
    // MARK: - Variables
    
    public var name: String
    
    public var current: Double
    public var ideal: Double
    
    public var min: Double
    public var max: Double
    
    public var unit: Unit?
    
    public static var source = Stock1D(name: "source", current: .infinity, ideal: -.infinity, min: -.infinity, max: .infinity)
    public static var sink = Stock1D(name: "sink", current: -.infinity, ideal: .infinity, min: -.infinity, max: .infinity)
    
    // MARK: - Initialization
    
    public init(name: String, current: Double, ideal: Double, min: Double, max: Double, unit: Unit? = nil)
    {
        self.name = name
        self.current = current
        self.ideal = ideal
        self.min = min
        self.max = max
        self.unit = unit
    }
}

// MARK: - Stock protocol

extension Stock1D
{
    public var balance: Double
    {
        let delta = abs(current - ideal)
        let scale = Swift.max(max - ideal, ideal - min)
        return 1 - delta / scale
    }
}

extension Stock1D: CustomStringConvertible
{
    public var description: String
    {
        "Stock (\(name)): \(current)"
    }
}

extension Stock1D: Equatable
{
    public static func ==(lhs: Stock1D, rhs: Stock1D) -> Bool
    {
        lhs === rhs
    }
}
