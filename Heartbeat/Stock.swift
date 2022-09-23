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
    private var _maximum: ValueClosure
    private var _ideal: ValueClosure
    
    public var current: Double
    {
        get { _current() }
        set { _current = { newValue } }
    }
    
    public var maximum: Double
    {
        get { _maximum() }
        set { _maximum = { newValue } }
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
        maximum: @escaping ValueClosure,
        ideal: @escaping ValueClosure)
    {
        self.name = name
        self.unit = unit
        
        self._current = current
        self._maximum = maximum
        self._ideal = ideal
    }
    
    // MARK: - Functions
    
    public var delta: Double
    {
        current - ideal
    }
    
    public var balance: Double
    {
        1 - abs(delta) / maximum
    }
    
    public var maximumTransferAmount: Double
    {
        current
    }
    
    public var maximumReceiveAmount: Double
    {
        maximum - current
    }
    
    public func maximumTransferAmount(in unit: Unit) -> Double
    {
        self.unit.convert(
            value: maximumTransferAmount,
            to: unit)
    }
    
    public func maximumReceiveAmount(in unit: Unit) -> Double
    {
        self.unit.convert(
            value: maximumReceiveAmount,
            to: unit)
    }
    
    // TODO: This doesn't prevent going negative
    public func subtract(amount: Double, unit: Unit)
    {
        let unitAmount = unit.convert(value: amount, to: self.unit)
        current -= unitAmount
    }
    
    // TODO: This doesn't prevent going above the max
    // the problem is that somehow, we aren't conserving energy
    // unless we return the remaining, non-added amount and
    // re-incorporate it back into the other stock
    public func add(amount: Double, unit: Unit)
    {
        let unitAmount = unit.convert(value: amount, to: self.unit)
        current += unitAmount
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
    static let source = Stock(
        name: "source",
        unit: .any,
        current: { .infinity },
        maximum: { .infinity },
        ideal: { -.infinity })
    
    static let sink = Stock(
        name: "sink",
        unit: .any,
        current: { -.infinity },
        maximum: { .infinity },
        ideal: { .infinity })
}
