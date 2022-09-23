//
//  Unit.swift
//  Heartbeat
//
//  Created by Joshua Grant on 9/23/22.
//

import Foundation

open class Unit
{
    // MARK: - Variables
    
    public var dimension: Dimension
    public var ratio: Double // TODO: Is this the best way of doing it?
    
    // MARK: - Initialization
    
    public init(dimension: Dimension, ratio: Double)
    {
        self.dimension = dimension
        self.ratio = ratio
    }
    
    public func canConvert(to unit: Unit) -> Bool
    {
        if unit == .any || self == .any { return true }
        return unit.dimension == dimension
    }
    
    public func convert(value: Double, to unit: Unit) -> Double
    {
        guard self.canConvert(to: unit) else
        {
            return 0
        }
        
        let ratio = unit.ratio / self.ratio
        return ratio * value
    }
}

public extension Unit
{
    // Volume
    static let liters = Unit(dimension: .volume, ratio: 1.0)
    static let gallons = Unit(dimension: .volume, ratio: 0.26417205)
    
    // Length
    static let meters = Unit(dimension: .length, ratio: 1.0)
    static let feet = Unit(dimension: .length, ratio: 3.28084)
    
    // Energy
    static let joules = Unit(dimension: .energy, ratio: 1.0)
    static let calories = Unit(dimension: .energy, ratio: 0.238846)
    
    // Area
    static let metersSquared = Unit(dimension: .area, ratio: 1.0)
    static let acres = Unit(dimension: .area, ratio: 2.471052e-4)
    
    // Numeric
    static let any = Unit(dimension: .utility, ratio: 1.0)
}

extension Unit: Equatable
{
    public static func == (lhs: Unit, rhs: Unit) -> Bool
    {
        lhs.dimension == rhs.dimension &&
        lhs.ratio == rhs.ratio
    }
}
