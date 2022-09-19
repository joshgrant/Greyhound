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
    
    // MARK: - Initialization
    
    init()
    {
        stomach = Stock(current: 0, ideal: { 100 }, min: 0, max: 100)
        
        eat = Flow(from: .source, to: stomach, amount: 20, duration: 1)
        digest = Flow(from: stomach, to: .sink, amount: 0.1, duration: 1)
        
        super.init(stocks: [stomach], flows: [eat, digest])
    }
}
