//
//  Stock.swift
//  Client
//
//  Created by Joshua Grant on 9/16/22.
//

import Foundation
import Spatial

enum Sign
{
    case positive
    case negative
    case neither
}

class Stock1D: Stock
{
    typealias CurrentModifier = (Double) -> Double
    
    // MARK: - Variables
    
    var current: Double
    var ideal: Double
    
    var min: Double
    var max: Double
    
    var unit: Unit?
    
    var balance: Double
    {
        let delta = abs(current - ideal)
        let scale = Swift.max(max - ideal, ideal - min)
        return 1 - delta / scale
    }
    
    // MARK: - Initialization
    
    init(current: Double, ideal: Double, min: Double, max: Double, unit: Unit? = nil)
    {
        self.current = current
        self.ideal = ideal
        self.min = min
        self.max = max
        self.unit = unit
    }
    
    convenience init(
        stock: Stock1D,
        current: Double? = nil,
        ideal: Double? = nil,
        min: Double? = nil,
        max: Double? = nil,
        unit: Unit? = nil)
    {
        self.init(
            current: current ?? stock.current,
            ideal: ideal ?? stock.ideal,
            min: min ?? stock.min,
            max: max ?? stock.max,
            unit: unit ?? stock.unit)
    }
    
    convenience init(stock: Stock1D, modifier: CurrentModifier? = nil)
    {
        self.init(
            stock: stock,
            current: modifier?(stock.current) ?? stock.current)
    }
    
    // MARK: - Functions
    
    func remove(amount: Double)
    {
        current -= amount
    }
    
    func add(amount: Double)
    {
        current += amount
    }
}

extension Stock1D: Equatable
{
    static func ==(lhs: Stock1D, rhs: Stock1D) -> Bool
    {
        lhs === rhs
    }
}

extension Stock1D: CustomStringConvertible
{
    var description: String
    {
        "Current: \(current)"
    }
}
