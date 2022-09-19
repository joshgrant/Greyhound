//
//  DigestiveSystem.swift
//  HeartbeatDemo
//
//  Created by Joshua Grant on 9/19/22.
//

import Foundation
import Heartbeat

class DigestiveSystem: System
{
    // MARK: - Variables
    
    var stomach: Stock
    
    var eat: Flow
    var digest: Flow
    
    var foodSource: () -> Stock
    
    // MARK: - Initialization
    
    init(foodSource: @escaping () -> Stock)
    {
        self.foodSource = foodSource
        stomach = Stock(current: 0, ideal: { 100 }, min: 0, max: 100, unit: UnitFood.unit)
        
        // TODO: These can't come from `source` or go to `sink`... they
        // have to come from something...
        // So "digest" is really like a "sense"... where the
        // food comes from the environment... right???
        // So the square needs to have food...
        eat = Flow(from: foodSource(), to: stomach, amount: 20, duration: 1)
        digest = Flow(from: stomach, to: .sink, amount: 0.1, duration: 1)
        
        super.init(stocks: [stomach], flows: [eat, digest])
    }
}
