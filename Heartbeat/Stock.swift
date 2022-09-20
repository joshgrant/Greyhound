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
    
    public var current: Double { _current() }
    public var maximum: Double { _maximum() }
    public var ideal: Double { _ideal() }
    
    // MARK: - Initialization
    
    init(
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

//open class Stock
//{
//    // MARK: - Variables
//
//    var uuid = UUID()
//
//    public var name: String?
//
//    public var current: UInt64
//    public var ideal: () -> Double?
//
//    public var min: Double
//    public var max: Double
//
//    public var unit: Unit?
//
//    // MARK: - Initialization
//
//    public init(
//        name: String? = nil,
//        current: Double,
//        ideal: @escaping () -> Double?,
//        min: Double,
//        max: Double,
//        unit: Unit? = nil)
//    {
//        self.name = name
//        self.current = current
//        self.ideal = ideal
//        self.min = min
//        self.max = max
//        self.unit = unit
//    }
//}
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
//
//extension Stock: CustomStringConvertible
//{
//    public var description: String
//    {
//        "Stock (\(name ?? "")): \(current)"
//    }
//}
//
//extension Stock: Equatable
//{
//    public static func ==(lhs: Stock, rhs: Stock) -> Bool
//    {
//        lhs === rhs
//    }
//}
//
//// MARK: - Global stocks
//
//extension Stock
//{
//    public static var source = Stock(
//        name: "source",
//        current: .infinity,
//        ideal: { -.infinity },
//        min: -.infinity,
//        max: .infinity)
//
//    public static var sink = Stock(
//        name: "sink",
//        current: -.infinity,
//        ideal: { .infinity },
//        min: -.infinity,
//        max: .infinity)
//}
//
//extension Stock: Hashable
//{
//    public func hash(into hasher: inout Hasher)
//    {
//        hasher.combine(uuid)
//    }
//}
