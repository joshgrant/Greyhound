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

class Stock<T: Primitive3D>
{
    typealias CurrentModifier = (T) -> T
    
    // MARK: - Variables
    
    var current: T
    var ideal: T
    
    var min: T
    var max: T
    
    var unit: Unit?
    
    var balance: T
    {
        let delta = abs(current - ideal)
        let scale = Swift.max(max - ideal, ideal - min)
        return 1 - delta / scale
    }
    
    var sign: Sign
    {
        if current > ideal
        {
            return .positive
        }
        else if current < ideal
        {
            return .negative
        }
        else
        {
            return .neither
        }
    }
    
    // MARK: - Initialization
    
    init(current: T, ideal: T, min: T, max: T, unit: Unit? = nil)
    {
        self.current = current
        self.ideal = ideal
        self.min = min
        self.max = max
        self.unit = unit
    }
    
    convenience init(
        stock: Stock,
        current: T? = nil,
        ideal: T? = nil,
        min: T? = nil,
        max: T? = nil,
        unit: Unit? = nil)
    {
        self.init(
            current: current ?? stock.current,
            ideal: ideal ?? stock.ideal,
            min: min ?? stock.min,
            max: max ?? stock.max,
            unit: unit ?? stock.unit)
    }
    
    convenience init(stock: Stock, modifier: CurrentModifier? = nil)
    {
        self.init(
            stock: stock,
            current: modifier?(stock.current) ?? stock.current)
    }
}

extension Stock: CustomStringConvertible
{
    var description: String
    {
        "Current: \(current)"
    }
}
