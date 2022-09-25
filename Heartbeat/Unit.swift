//
//  Unit.swift
//  Heartbeat
//
//  Created by Joshua Grant on 9/23/22.
//

import Foundation

public class Unit<DimensionType: Dimension>
{
    // MARK: - Variables
    
    public var ratioToBase: Double
    
    // MARK: - Initialization
    
    public init(ratioToBase: Double)
    {
        self.ratioToBase = ratioToBase
    }
    
    // MARK: - Functions
    
    func canConvert(to unit: Unit) -> Bool
    {
        self.id == Unit<Number>.any.id ||
        unit.id == Unit<Number>.any.id ||
        type(of: self) == type(of: unit)
    }
}

extension Unit: Identifiable {}

extension Unit: Hashable
{
    public static func == (
        lhs: Unit<DimensionType>,
        rhs: Unit<DimensionType>)
    -> Bool
    {
        lhs.id == rhs.id
    }
    
    public func hash(into hasher: inout Hasher)
    {
        hasher.combine(id)
    }
}

let _any = Unit<Number>(ratioToBase: 1)
let _liters = Unit<Volume>(ratioToBase: 1)
let _gallons = Unit<Volume>(ratioToBase: 0.26)
let _meters = Unit<Length>(ratioToBase: 1.0)
let _feet = Unit<Length>(ratioToBase: 3.28)

extension Unit
{
    static var any: Unit<Number> { _any }
    
    static var liters: Unit<Volume> { _liters }
    static var gallons: Unit<Volume> { _gallons }
    
    static var meters: Unit<Length> { _meters }
    static var feet: Unit<Length> { _feet }
}

//public class UnitLength: Unit
//{
//    static let meters = UnitLength(ratioToBase: 1)
//    static let feet = UnitLength(ratioToBase: 3.28)
//}

//open class Unit
//{
//    // MARK: - Variables
//    
//    public var dimension: Dimension
//    public var ratioToBase: Double
//    
//    // MARK: - Initialization
//    
//    public init(dimension: Dimension, ratioToBase: Double)
//    {
//        self.dimension = dimension
//        self.ratioToBase = ratioToBase
//    }
//    
//    public func canConvert(to unit: Unit) -> Bool
//    {
//        self == .any ||
//        unit == .any ||
//        unit.dimension == dimension
//    }
//    
//    public func convert(value: Double, to unit: Unit) -> Double
//    {
//        guard self.canConvert(to: unit) else
//        {
//            return 0
//        }
//        
//        let ratio = unit.ratioToBase / self.ratioToBase
//        return ratio * value
//    }
//}
//
//public extension Unit
//{
//    // Volume
//    static let liters = Unit(dimension: .volume, ratioToBase: 1.0)
//    static let gallons = Unit(dimension: .volume, ratioToBase: 0.26417205)
//    
//    // Length
//    static let meters = Unit(dimension: .length, ratioToBase: 1.0)
//    static let feet = Unit(dimension: .length, ratioToBase: 3.28084)
//    
//    // Energy
//    static let joules = Unit(dimension: .energy, ratioToBase: 1.0)
//    static let calories = Unit(dimension: .energy, ratioToBase: 0.238846)
//    
//    // Area
//    static let metersSquared = Unit(dimension: .area, ratioToBase: 1.0)
//    static let acres = Unit(dimension: .area, ratioToBase: 0.0002471053815)
//    
//    // Numeric
//    static let any = Unit(dimension: .utility, ratioToBase: 1.0)
//    
//    // System
//    static let system = Unit(dimension: .system, ratioToBase: 1.0)
//}
//
//extension Unit: Equatable
//{
//    public static func == (lhs: Unit, rhs: Unit) -> Bool
//    {
//        lhs.dimension == rhs.dimension &&
//        lhs.ratioToBase == rhs.ratioToBase
//    }
//}
