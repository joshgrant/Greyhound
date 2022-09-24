//
//  Stock.swift
//  Client
//
//  Created by Joshua Grant on 9/16/22.
//

import Foundation

open class Stock
{
    // MARK: - Defined types
    
    public typealias ValueClosure = () -> Double
    
    // MARK: - Variables
    
    public var name: String? = nil
    
    public var unit: Unit
    
    private var _current: ValueClosure
    private var _maximum: ValueClosure?
    private var _ideal: ValueClosure
    
    public var current: Double
    {
        get { _current() }
        set { _current = { newValue } }
    }
    
    public var maximum: Double?
    {
        get { _maximum?() ?? nil }
        set {
            guard let newValue = newValue else
            {
                _maximum = nil
                return
            }
            _maximum = { newValue }
        }
    }
    
    public var ideal: Double
    {
        get { _ideal() }
        set { _ideal = { newValue } }
    }
    
    // MARK: - Initialization
    
    public init(
        name: String? = nil,
        unit: Unit,
        current: @escaping ValueClosure,
        maximum: ValueClosure?,
        ideal: @escaping ValueClosure)
    {
        self.name = name
        self.unit = unit
        
        self._current = current
        self._maximum = maximum
        self._ideal = ideal
    }
    
    // MARK: - Functions
    
    public var pressure: Double
    {
        if let maximum = maximum
        {
            return current - min(ideal, maximum)
        }
        else
        {
            return current - ideal
        }
    }
    
    public var pressureInBase: Double
    {
        unit.convert(
            value: pressure,
            to: unit.dimension.baseUnit)
    }
    
    public var currentInBase: Double
    {
        get
        {
            unit.convert(
                value: current,
                to: unit.dimension.baseUnit)
        }
        set
        {
            current = unit
                .dimension
                .baseUnit
                .convert(value: newValue, to: unit)
        }
    }
    
    public var capacityInBase: Double
    {
        if let maximum = maximum
        {
            return unit.convert(
                value: maximum - current,
                to: unit.dimension.baseUnit)
        }
        else
        {
            return .greatestFiniteMagnitude
        }
    }
}

extension Stock: Identifiable { }

extension Stock: Hashable
{
    public static func == (lhs: Stock, rhs: Stock) -> Bool
    {
        lhs.id == rhs.id
    }
    
    public func hash(into hasher: inout Hasher)
    {
        hasher.combine(id)
    }
}

public extension Stock
{
    static let source: Stock = ImmutableStock(
        name: "source",
        unit: .any,
        current: .greatestFiniteMagnitude,
        maximum: nil,
        ideal: 0)
    
    static let sink: Stock = ImmutableStock(
        name: "sink",
        unit: .any,
        current: 0,
        maximum: nil,
        ideal: .greatestFiniteMagnitude)
}

private class ImmutableStock: Stock
{
    var fixedUnit: Unit
    var fixedCurrent: Double
    var fixedMaximum: Double?
    var fixedIdeal: Double
    
    override var unit: Unit
    {
        get { fixedUnit }
        set { }
    }
    
    override var current: Double
    {
        get { fixedCurrent }
        set { }
    }
    
    override var maximum: Double?
    {
        get { fixedMaximum }
        set { }
    }
    
    override var ideal: Double
    {
        get { fixedIdeal }
        set { }
    }
    
    init(
        name: String? = nil,
        unit: Unit,
        current: Double,
        maximum: Double?,
        ideal: Double)
    {
        self.fixedUnit = unit
        self.fixedCurrent = current
        self.fixedMaximum = maximum
        self.fixedIdeal = ideal
        
        var maximumClosure: ValueClosure?
        
        if let maximum = maximum
        {
            maximumClosure = { maximum }
        }
        
        super.init(
            name: name,
            unit: unit,
            current: { current },
            maximum: maximumClosure,
            ideal: { ideal })
    }
}
