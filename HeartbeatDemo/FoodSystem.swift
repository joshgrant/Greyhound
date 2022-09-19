//
//  FoodSystem.swift
//  HeartbeatDemo
//
//  Created by Joshua Grant on 9/19/22.
//

import Foundation
import Heartbeat

class FoodSystem: System
{
    // MARK: - Variables
    
    var positionSystem: PositionSystem
    var resource: Stock
    
    // MARK: - Initialization
    
    init()
    {
        positionSystem = PositionSystem(x: 1000, y: 1000, xIdeal: { 500 }, yIdeal: { 500 })
        resource = Stock(name: "food", current: 30, ideal: { 100 }, min: 0, max: 100, unit: UnitFood.unit)
        
        super.init(stocks: [resource], flows: [], subsystems: [positionSystem])
    }
}
