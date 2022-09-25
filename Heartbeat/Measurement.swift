//
//  Measurement.swift
//  Heartbeat
//
//  Created by Joshua Grant on 9/24/22.
//

import Foundation

open class Measurement<DimensionType: Dimension>
{
    // MARK: - Variables
    
    public var value: Double
    public var unit: Unit<DimensionType>
    
    // MARK: - Initialization
    
    public init(value: Double, unit: Unit<DimensionType>)
    {
        self.value = value
        self.unit = unit
    }
    
    // MARK: - Functions
    
    var valueInBase: Double
    {
        value * unit.ratioToBase
    }
    
    func value(in unit: Unit<DimensionType>) -> Double
    {
        value * self.unit.ratioToBase / unit.ratioToBase
    }
}

extension Measurement: Comparable
{
    public static func < (
        lhs: Measurement<DimensionType>,
        rhs: Measurement<DimensionType>)
    -> Bool
    {
        lhs.value < rhs.value
    }
    
    public static func == (
        lhs: Measurement<DimensionType>,
        rhs: Measurement<DimensionType>)
    -> Bool
    {
        lhs.value == rhs.value
    }
}

extension Measurement
{
    static func - (
        lhs: Measurement,
        rhs: Measurement)
    -> Measurement
    {
        Measurement(
            value: lhs.value - rhs.value(in: lhs.unit),
            unit: lhs.unit)
    }
    
    static func -= (
        lhs: Measurement,
        rhs: Measurement)
    {
        lhs.value -= rhs.value(in: lhs.unit)
    }
    
    static func + (
        lhs: Measurement,
        rhs: Measurement)
    -> Measurement
    {
        Measurement(
            value: lhs.value + rhs.value(in: lhs.unit),
            unit: lhs.unit)
    }
    
    static func += (
        lhs: Measurement,
        rhs: Measurement)
    {
        lhs.value += rhs.value(in: lhs.unit)
    }
}
