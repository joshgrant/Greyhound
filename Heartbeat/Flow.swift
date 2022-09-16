//
//  Flow.swift
//  
//
//  Created by Joshua Grant on 9/15/22.
//

import Foundation
import Numerics

struct Flow<T: Real>
{
    var from: Stock<T>
    var to: Stock<T>
    
    var amount: T = 1
    var duration: TimeInterval = 1
    var delay: TimeInterval = 0
    
    var isRunning: Bool = false
    var repeats: Bool = false
}
