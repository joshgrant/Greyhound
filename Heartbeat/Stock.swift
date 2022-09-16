//
//  Stock.swift
//  
//
//  Created by Joshua Grant on 9/15/22.
//

import Foundation
import Numerics

public struct Stock<T: Real>
{
    var current: T
    var ideal: T
    
    var min: T
    var max: T
    
    var unit: Unit
}

extension Stock
{
    var imbalance: T {
        T.percentDelta(
            a: current,
            b: ideal,
            minimum: min,
            maximum: max)
    }
}
