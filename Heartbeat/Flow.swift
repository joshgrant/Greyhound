//
//  Flow.swift
//  Heartbeat
//
//  Created by Joshua Grant on 9/18/22.
//

import Foundation

protocol Flow: AnyObject, CustomStringConvertible, Equatable
{
    associatedtype Stock
    
    var from: Stock { get set }
    var to: Stock { get set }
    
    var amount: Double { get set }
    var duration: TimeInterval { get set }
}
