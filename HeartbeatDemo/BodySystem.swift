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
    
    public var eyes: Input<CGPoint>
    public var mouth: Input<Stock>
    
    public lazy var positionSystem: PositionSystem = {
        PositionSystem(
            x: 0,
            y: 0,
            xIdeal: xIdeal,
            yIdeal: yIdeal)
    }()
    
    public lazy var digestive = DigestiveSystem(mouth: mouth)
    
    // MARK: - Initialization
    
    public init(eyes: Input<CGPoint>, mouth: Input<Stock>)
    {
        self.eyes = eyes
        self.mouth = mouth
        super.init(stocks: [], flows: [], subsystems: [])
        self.subsystems = [positionSystem, digestive] // Something about accessing self before super.init
    }
    
    private func xIdeal() -> Double?
    {
        eyes.source?.x.doubleValue
    }
    
    private func yIdeal() -> Double?
    {
        eyes.source?.y.doubleValue
    }
}

extension CGFloat
{
    var doubleValue: Double
    {
        return Double(self)
    }
}
