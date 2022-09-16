//
//  Procedure.swift
//  
//
//  Created by Joshua Grant on 9/15/22.
//

import Foundation
import Numerics

struct Procedure<T: Real>
{
    /// The stock that's monitored
    var stock: Stock<T>
    
    /// The value of imbalance that the stock has to be in for the
    /// flows to get executed
    var thresholdRange: ClosedRange<T>
    
    /// When the imbalance is met, these flows are executed in order
    var flows: [Flow<T>]
}

extension Procedure where T: Real
{
    var canExecute: Bool
    {
        thresholdRange.contains(stock.imbalance)
    }
}
