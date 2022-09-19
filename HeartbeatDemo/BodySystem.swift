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
    
    public var foodSensor: Sensor<CGPoint>
    public var foodSource: () -> Stock
    
    public lazy var positionSystem: PositionSystem = {
        PositionSystem(
            x: 0,
            y: 0,
            xIdeal: xIdeal,
            yIdeal: yIdeal)
    }()
    
    public lazy var digestive = DigestiveSystem(foodSource: foodSource)
    
    // MARK: - Initialization
    
    public init(foodSensor: Sensor<CGPoint>, foodSource: @escaping () -> Stock)
    {
        self.foodSensor = foodSensor
        self.foodSource = foodSource
        super.init(stocks: [], flows: [], subsystems: [])
        self.subsystems = [positionSystem, digestive] // Something about accessing self before super.init
    }
    
    private func xIdeal() -> Double?
    {
        foodSensor.value?.x.doubleValue
    }
    
    private func yIdeal() -> Double?
    {
        foodSensor.value?.y.doubleValue
    }
}

extension CGFloat
{
    var doubleValue: Double
    {
        return Double(self)
    }
}
