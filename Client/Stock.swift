//
//  Stock.swift
//  Client
//
//  Created by Joshua Grant on 9/16/22.
//

import Foundation

enum Sign
{
    case positive
    case negative
    case neither
}

class Stock<T: FloatingPoint>
{
    typealias CurrentModifier = (T) -> T
    
    // MARK: - Variables
    
    var uuid: UUID
    
    var current: T
    var ideal: T
    
    var minimum: T
    var maximum: T
    
    var balance: T
    {
        let delta = abs(current - ideal)
        let scale = max(maximum - ideal, ideal - minimum)
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
    
    init(current: T, ideal: T, minimum: T, maximum: T, uuid: UUID = UUID())
    {
        self.current = current
        self.ideal = ideal
        self.minimum = minimum
        self.maximum = maximum
        self.uuid = uuid
    }
    
    convenience init(
        stock: Stock,
        current: T? = nil,
        ideal: T? = nil,
        minimum: T? = nil,
        maximum: T? = nil,
        uuid: UUID? = nil)
    {
        self.init(
            current: current ?? stock.current,
            ideal: ideal ?? stock.ideal,
            minimum: minimum ?? stock.minimum,
            maximum: maximum ?? stock.maximum,
            uuid: uuid ?? stock.uuid)
    }
    
    convenience init(stock: Stock, modifier: CurrentModifier? = nil)
    {
        self.init(
            stock: stock,
            current: modifier?(stock.current) ?? stock.current)
    }
}

extension Stock: Equatable
{
    static func == (lhs: Stock<T>, rhs: Stock<T>) -> Bool
    {
        lhs.uuid == rhs.uuid
    }
}

extension Stock: CustomStringConvertible
{
    var description: String
    {
        "Current: \(current)"
    }
}
