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
    
    public var unit: Unit?
    
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
        unit: Unit?,
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
        unit: nil,
        current: { .infinity },
        maximum: { .infinity },
        ideal: { -.infinity })
    
    static let sink = Stock(
        name: "sink",
        unit: nil,
        current: { -.infinity },
        maximum: { .infinity },
        ideal: { .infinity })
}

//
//// MARK: - Stock protocol
//
//extension Stock
//{
//    public var balance: Double?
//    {
//        guard let ideal = ideal() else { return nil }
//
//        let delta = abs(current - ideal)
//        let scale = Swift.max(max - ideal, ideal - min)
//        return 1 - delta / scale
//    }
//
//    public func balance(with bondedStock: Stock) -> Double?
//    {
//        guard let ideal = ideal() else { return nil }
//        guard let otherIdeal = bondedStock.ideal() else { return nil }
//
//        // Calculate the respective deltas
//        let deltaSelf = current - ideal
//        let deltaOther = bondedStock.current - otherIdeal
//
//        var newDelta = abs(deltaSelf)
//
//        if deltaSelf.sign != deltaOther.sign
//        {
//            let amount = Swift.min(abs(deltaSelf), abs(deltaOther))
//
//            print("AMOUNT: \(amount)")
//
//            let newCurrent: Double
//
//            if current < ideal
//            {
//                newCurrent = current + amount
//            }
//            else if current > ideal
//            {
//                newCurrent = current - amount
//            }
//            else
//            {
//                newCurrent = current
//            }
//
//            newDelta = abs(newCurrent - ideal)
//        }
//
//        let scale = Swift.max(max - ideal, ideal - min)
//        print("SCALE: \(scale)")
//        print("NEW DELTA: \(newDelta)")
//        return 1 - newDelta / scale
//    }
//
//    public var sign: ComparisonResult?
//    {
//        guard let ideal = ideal() else { return nil }
//        if current > ideal
//        {
//            return .orderedAscending
//        }
//        else if current < ideal
//        {
//            return .orderedDescending
//        }
//        else
//        {
//            return .orderedSame
//        }
//    }
//}
