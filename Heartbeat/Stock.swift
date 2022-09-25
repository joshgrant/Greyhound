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
    
    var name: String? { get }
    var current: Measurement<DimensionType> { get set }
    var maximum: Measurement<DimensionType>? { get set }
    var ideal: Measurement<DimensionType> { get set }
}

open class Stock<DimensionType: Dimension>: StockType
{
    // MARK: - Variables
    
    public let name: String?
    
    public var current: Measurement<DimensionType>
    public var maximum: Measurement<DimensionType>?
    public var ideal: Measurement<DimensionType>
    
    public var pressure: Measurement<DimensionType>
    {
        // We need to ensure that we convert
        // everything to the same unit??
        // What can measurements do? Are they always the
        // same?
        current - min(ideal, maximum ?? ideal)
    }
    
    // MARK: - Initialization
    
    public init(
        name: String? = nil,
        current: Measurement<DimensionType>,
        maximum: Measurement<DimensionType>?,
        ideal: Measurement<DimensionType>)
    {
        self.name = name
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

let _source = Stock<Number>(
    name: "source",
    current: Measurement(value: .greatestFiniteMagnitude, unit: .any),
    maximum: nil,
    ideal: Measurement(value: 0, unit: .any))

let _sink = Stock(
    name: "sink",
    current: Measurement(value: 0, unit: .any),
    maximum: nil,
    ideal: Measurement(value: .greatestFiniteMagnitude, unit: .any))

public extension Stock
{
    static var source: Stock<Number> { _source }
    static var sink: Stock<Number> { _sink }
}
