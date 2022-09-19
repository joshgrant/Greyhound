//
//  PositionSystem.swift
//  HeartbeatDemo
//
//  Created by Joshua Grant on 9/18/22.
//

import Foundation
import Heartbeat

class PositionSystem: System
{
    // MARK: - Variables
    
    var xIdeal: () -> Double?
    var yIdeal: () -> Double?
    
    var x: Stock
    var y: Stock
    
    var xPositive: Flow
    var yPositive: Flow
    var xNegative: Flow
    var yNegative: Flow
    
    var position: CGPoint
    {
        get
        {
            CGPoint(x: x.current, y: y.current)
        }
        set
        {
            x.current = newValue.x
            y.current = newValue.y
        }
    }
    
    // MARK: - Initialization
    
    init(
        x xVal: Double,
        y yVal: Double,
        xIdeal: @escaping () -> Double?,
        yIdeal: @escaping () -> Double?)
    {
        self.xIdeal = xIdeal
        self.yIdeal = yIdeal
        
        x = Stock(current: xVal, ideal: xIdeal, min: 0, max: 1000)
        y = Stock(current: yVal, ideal: yIdeal, min: 0, max: 1000)
        
        xPositive = Flow(from: .source, to: x, amount: 1, duration: 0.01)
        yPositive = Flow(from: .source, to: y, amount: 1, duration: 0.01)
        xNegative = Flow(from: x, to: .sink, amount: 1, duration: 0.01)
        yNegative = Flow(from: y, to: .sink, amount: 1, duration: 0.01)
        
        super.init(
            stocks: [x, y],
            flows: [xPositive, yPositive, xNegative, yNegative])
    }
}
