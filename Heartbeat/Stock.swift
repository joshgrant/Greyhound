//
//  Stock.swift
//  
//
//  Created by Joshua Grant on 9/15/22.
//

import Foundation
import Numerics

public class Stock<T: Real>
{
    // MARK: - Variables
    
    var uuid = UUID()
    
    var current: T
    var ideal: T
    
    var min: T
    var max: T
    
    var unit: Unit
    
    // MARK: - Initialization
    
    init(
        current: T,
        ideal: T,
        min: T,
        max: T,
        unit: Unit = UnitEnergy.joules)
    {
        self.current = current
        self.ideal = ideal
        self.min = min
        self.max = max
        self.unit = unit
    }
}

extension Stock
{
    var balance: T {
        T.percentDelta(
            a: current,
            b: ideal,
            minimum: min,
            maximum: max)
    }
}

extension Stock: Equatable
{
    public static func == (lhs: Stock<T>, rhs: Stock<T>) -> Bool
    {
        lhs.uuid == rhs.uuid
    }
}
