//
//  Flow.swift
//  
//
//  Created by Joshua Grant on 9/15/22.
//

import Foundation
import Numerics

class Flow<T: Real>
{
    // MARK: - Variables
    
    var from: Stock<T>
    var to: Stock<T>
    
    var amount: T = 1
    var duration: TimeInterval = 1
    var delay: TimeInterval = 0
    
    var isRunning: Bool = false
    var repeats: Bool = false
    
    // MARK: - Initialization
    
    init(
        from: Stock<T>,
        to: Stock<T>,
        amount: T = 1,
        duration: TimeInterval = 1,
        delay: TimeInterval = 0,
        isRunning: Bool = false,
        repeats: Bool = false)
    {
        self.from = from
        self.to = to
        self.amount = amount
        self.duration = duration
        self.delay = delay
        self.isRunning = isRunning
        self.repeats = repeats
    }
}
