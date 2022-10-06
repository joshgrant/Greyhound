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
    
    public var id = UUID()
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

extension Unit: Identifiable
{
    public typealias ID = UUID
}

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
let _gallons = Unit<Volume>(ratioToBase: 3.7854)

let _meters = Unit<Length>(ratioToBase: 1.0)
let _feet = Unit<Length>(ratioToBase: 0.3048)

let _joules = Unit<Energy>(ratioToBase: 1.0)
let _calories = Unit<Energy>(ratioToBase: 4.184)

let _squareMeters = Unit<Area>(ratioToBase: 1)
let _acres = Unit<Area>(ratioToBase: 4046.86)

let _grams = Unit<Mass>(ratioToBase: 1)
let _kilograms = Unit<Mass>(ratioToBase: 1000)
let _pounds = Unit<Mass>(ratioToBase: 453.592)


extension Unit
{
    public static var any: Unit<Number> { _any }
    
    public static var liters: Unit<Volume> { _liters }
    public static var gallons: Unit<Volume> { _gallons }
    
    public static var meters: Unit<Length> { _meters }
    public static var feet: Unit<Length> { _feet }
    
    public static var joules: Unit<Energy> { _joules }
    public static var calories: Unit<Energy> { _calories }
    
    public static var squareMeters: Unit<Area> { _squareMeters }
    public static var acres: Unit<Area> { _acres }
    
    public static var grams: Unit<Mass> { _grams }
    public static var kilograms: Unit<Mass> { _kilograms }
    public static var pounds: Unit<Mass> { _pounds }
}
