//
//  Stock.swift
//  Client
//
//  Created by Joshua Grant on 9/16/22.
//

import Foundation

open class Stock1D: Stock
{
    public typealias CurrentModifier = (Double) -> Double
    
    // MARK: - Variables
    
    public var name: String
    
    public var current: Double
    public var ideal: Double
    
    public var min: Double
    public var max: Double
    
    public var unit: Unit?
    
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
    
    public convenience init(
        stock: Stock1D,
        name: String? = nil,
        current: Double? = nil,
        ideal: Double? = nil,
        min: Double? = nil,
        max: Double? = nil,
        unit: Unit? = nil)
    {
        self.init(
            name: name ?? stock.name,
            current: current ?? stock.current,
            ideal: ideal ?? stock.ideal,
            min: min ?? stock.min,
            max: max ?? stock.max,
            unit: unit ?? stock.unit)
    }
    
    public convenience init(stock: Stock1D, modifier: CurrentModifier? = nil)
    {
        self.init(
            stock: stock,
            current: modifier?(stock.current) ?? stock.current)
    }
}

// MARK: - Stock protocol

extension Stock1D
{
    var balance: Double
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
