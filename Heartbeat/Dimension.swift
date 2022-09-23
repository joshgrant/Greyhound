//
//  Dimension.swift
//  Heartbeat
//
//  Created by Joshua Grant on 9/23/22.
//

import Foundation

// We have a dimension - i.e an axis of measurement
// We have a value - i.e a number along the axis
// We have a unit - i.e a way to scale numbers for ease-of-use

/*
 
 Dimension: Volume
 Value: 5
 Unit: gallons
 
 */

public enum Dimension
{
    case volume
    case length
    case energy
    case area
    case utility
    
    var baseUnit: Unit
    {
        switch self
        {
        case .volume: return .liters
        case .length: return .meters
        case .energy: return .joules
        case .area: return .metersSquared
        case .utility: return .any
        }
    }
}

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
    
    func canConvert(to unit: Unit) -> Bool
    {
        if unit == .any { return true }
        return unit.dimension == dimension
    }
}

public extension Unit
{
    // Volume
    static let liters = Unit(dimension: .volume, ratio: 1.0)
    static let gallons = Unit(dimension: .volume, ratio: 0.26)
    
    // Length
    static let meters = Unit(dimension: .length, ratio: 1.0)
    static let feet = Unit(dimension: .length, ratio: 3.28)
    
    // Energy
    static let joules = Unit(dimension: .energy, ratio: 1.0)
    static let calories = Unit(dimension: .energy, ratio: 4.18)
    
    // Area
    static let metersSquared = Unit(dimension: .area, ratio: 1.0)
    static let acres = Unit(dimension: .area, ratio: 4_046.86)
    
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

open class Measurement
{
    // MARK: - Variables
    
    public var value: Double
    public var unit: Unit
    
    // MARK: - Initialization
    
    public init(value: Double, unit: Unit)
    {
        self.value = value
        self.unit = unit
    }
    
    // MARK: - Functions
    
    public func converted(to unit: Unit) -> Measurement?
    {
        guard self.unit.canConvert(to: unit) else { return nil }
        let value = unit.ratio * value
        return Measurement(value: value, unit: unit)
    }
}
