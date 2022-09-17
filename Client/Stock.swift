//
//  Stock.swift
//  Client
//
//  Created by Joshua Grant on 9/16/22.
//

import Foundation

struct Stock<T: FloatingPoint>
{
    typealias CurrentModifier = (T) -> T
    
    // MARK: - Variables
    
    var uuid = UUID()
    
    let current: T
    let ideal: T
    
    let minimum: T
    let maximum: T
    
    var balance: T
    {
        let delta = abs(current - ideal)
        let scale = max(maximum - ideal, ideal - minimum)
        return 1 - delta / scale
    }
    
    // MARK: - Initialization
    
    init(current: T, ideal: T, minimum: T, maximum: T)
    {
        self.current = current
        self.ideal = ideal
        self.minimum = minimum
        self.maximum = maximum
    }
    
    init(stock: Stock, current: T? = nil, ideal: T? = nil, minimum: T? = nil, maximum: T? = nil)
    {
        self.init(
            current: current ?? stock.current,
            ideal: ideal ?? stock.ideal,
            minimum: minimum ?? stock.minimum,
            maximum: maximum ?? stock.maximum)
    }
    
    init(stock: Stock, modifier: CurrentModifier? = nil)
    {
        self.init(
            stock: stock,
            current: modifier?(stock.current) ?? stock.current)
    }
}

extension Stock: Equatable
{
    
}

extension Stock: CustomStringConvertible
{
    var description: String
    {
        "Current: \(current)"
    }
}
