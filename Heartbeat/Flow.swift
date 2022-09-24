//
//  Flow.swift
//  Client
//
//  Created by Joshua Grant on 9/16/22.
//

import Foundation

enum FlowError: Error
{
    case incompatibleDimensions
}

open class Flow
{
    // MARK: - Defined types
    
    public typealias StockClosure = () -> Stock
    public typealias ValueClosure = () -> Double
    
    // MARK: - Variables
    
    public var name: String? = nil
    public let unit: Unit
    public var stockA: Stock { _stockA() }
    public var stockB: Stock { _stockB() }
    
    /// Units/second
    public var limit: Double?
    {
        get { _limit?() ?? nil }
        set {
            guard let newValue = newValue else
            {
                _limit = nil
                return
            }
            _limit = { newValue }
        }
    }
    
    var limitInBase: Double?
    {
        guard let limit = limit else { return nil }
        return unit.convert(
            value: limit,
            to: unit.dimension.baseUnit)
    }
    
    private var _stockA: StockClosure
    private var _stockB: StockClosure
    private var _limit: ValueClosure?
    
    private var pTimeInterval: TimeInterval?
    
    // MARK: - Initialization
    
    public init(
        name: String? = nil,
        unit: Unit,
        stockA: @escaping StockClosure,
        stockB: @escaping StockClosure,
        limit: ValueClosure?) throws
    {
        self.name = name
        self.unit = unit
        self._stockA = stockA
        self._stockB = stockB
        self._limit = limit
        
        guard self.stockA.unit.canConvert(to: self.unit) &&
                self.stockB.unit.canConvert(to: self.unit)
        else
        {
            throw FlowError.incompatibleDimensions
        }
    }
    
    // MARK: - Functions
    
    public func update(_ timeInterval: TimeInterval)
    {
        let elapsedTime = timeInterval - (pTimeInterval ?? timeInterval)
        
        let flowLimit = min(limitInBase ?? .greatestFiniteMagnitude, .greatestFiniteMagnitude)
        
        if stockA.pressureInBase > stockB.pressureInBase
        {
            let amount = min(
                flowLimit,
                stockA.currentInBase,
                stockB.capacityInBase)
            stockA.currentInBase -= amount
            stockB.currentInBase += amount
        }
        else
        {
            let amount = min(
                flowLimit,
                stockA.capacityInBase,
                stockB.currentInBase)
            stockA.currentInBase += amount
            stockB.currentInBase -= amount
        }
        
        
        pTimeInterval = timeInterval
    }
}

/// ARGH!!!!!
/// Multiplying .greatestFiniteMagnitude by anything gives you infinity
/// How can I avoid this???


/*
 let amountA = unit
     .dimension
     .baseUnit
     .convert(
         value: stockA.pressure,
         to: unit)
 
 let amountB = unit
     .dimension
     .baseUnit
     .convert(
         value: stockB.pressure,
         to: unit)
 
 let totalLimit = limit * elapsedTime
 let mint = min(
     abs(amountA),
     abs(amountB),
     totalLimit)
 let signA: Double = amountA < 0 ? -1 : 1 // Flips signs?
 let signB: Double = amountB < 0 ? -1 : 1 // Flips signs?
 let plusA = mint * signA
 let plusB = mint * signB
 
 print(amountA, amountB, mint, plusA, plusB)
 
 let plusAUnit = unit.convert(value: plusA, to: stockA.unit)
 
 
 let plusBUnit = unit.convert(value: plusB, to: stockB.unit)
 // AmountA needs to be constrained to the limit of the stock
 // AmountB needs to be constrainted to the limit of the stock
 
 stockA.current -= plusAUnit
 stockB.current -= plusBUnit
 */
