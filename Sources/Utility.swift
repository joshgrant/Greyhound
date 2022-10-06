//
//  Utility.swift
//  Heartbeat
//
//  Created by Joshua Grant on 9/25/22.
//

import Foundation

public func min<T: Comparable>(_ values: T?...) -> T?
{
    let values = values.compactMap { $0 }
    
    guard values.count > 0 else { return nil }
    
    var minimum: T = values.first!
    
    for value in values
    {
        if value < minimum
        {
            minimum = value
        }
    }
    
    return minimum
}

extension Double
{
    func multiplied(by amount: Double) -> Double
    {
        self * amount
    }
}
