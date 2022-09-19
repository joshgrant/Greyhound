//
//  BodySystem.swift
//  HeartbeatDemo
//
//  Created by Joshua Grant on 9/19/22.
//

import Foundation
import Heartbeat

class BodySystem: System
{
    // MARK: - Variables
    
    var foodSensor: Sensor<CGPoint>
    
    lazy var positionSystem: PositionSystem = {
        PositionSystem(
            x: 0,
            y: 0,
            xIdeal: xIdeal,
            yIdeal: yIdeal)
    }()
    
    lazy var digestive = DigestiveSystem()
    
    // MARK: - Initialization
    
    init(foodSensor: Sensor<CGPoint>)
    {
        self.foodSensor = foodSensor
        super.init(stocks: [], flows: [], subsystems: [])
        self.subsystems = [positionSystem, digestive] // Something about accessing self before super.init
    }
    
    func xIdeal() -> Double?
    {
        if let x = foodSensor.value?.x
        {
            return Double(x)
        }
        else
        {
            return nil
        }
    }
    
    func yIdeal() -> Double?
    {
        if let y = foodSensor.value?.y
        {
            return Double(y)
        }
        else
        {
            return nil
        }
    }
}
