//
//  Flow.swift
//  Heartbeat
//
//  Created by Joshua Grant on 9/18/22.
//

import Foundation

protocol Flow: AnyObject, CustomStringConvertible, Equatable
{
    associatedtype T: Stock
    
    var from: T { get set }
    var to: T { get set }
    
    var amount: Double { get set }
    var duration: TimeInterval { get set }
}
