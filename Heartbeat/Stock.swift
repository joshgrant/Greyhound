//
//  Stock.swift
//  Client
//
//  Created by Joshua Grant on 9/16/22.
//

import Foundation

public protocol StockType
{
    associatedtype DimensionType: Dimension
    var unit: Unit<DimensionType> { get }
}

open class Stock<DimensionType: Dimension>: StockType
{
    // MARK: - Variables
    
    public let name: String?
    public let unit: Unit<DimensionType>
    
    public var current: Double
    public var maximum: Double?
    public var ideal: Double
    
    public var pressure: Double
    {
        current - min(ideal, maximum ?? .greatest)
    }
    
    // Pressure in base?
    // Current in base?
    // Capacity in base?
    //
    
    // MARK: - Initialization
    
    public init(
        name: String? = nil,
        unit: Unit<DimensionType>,
        current: Double,
        maximum: Double?,
        ideal: Double)
    {
        self.name = name
        self.unit = unit
        self.current = current
        self.maximum = maximum
        self.ideal = ideal
    }
}

extension Stock: Identifiable {}

extension Stock: Hashable
{
    public static func == (
        lhs: Stock<DimensionType>,
        rhs: Stock<DimensionType>)
    -> Bool
    {
        lhs.id == rhs.id
    }
    
    public func hash(into hasher: inout Hasher)
    {
        hasher.combine(id)
    }
}

let _source = Stock(
    name: "source",
    unit: Unit<Number>.any,
    current: .greatest,
    maximum: nil,
    ideal: 0)

let _sink = Stock(
    name: "sink",
    unit: Unit<Number>.any,
    current: 0,
    maximum: nil,
    ideal: .greatest)


public extension Stock
{
    static var source: Stock<Number> { _source }
    static var sink: Stock<Number> { _sink }
}
