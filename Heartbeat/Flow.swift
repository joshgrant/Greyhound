//
//  Flow.swift
//  Heartbeat
//
//  Created by Joshua Grant on 9/18/22.
//

import Foundation

public protocol Flow: AnyObject, CustomStringConvertible, Equatable
{
    associatedtype T: Stock
    
    var name: String { get }
    
    var from: T { get set }
    var to: T { get set }
    
    var amount: T.T { get set }
    var duration: TimeInterval { get set }
    
    var transferAmount: T.T { get }
    
    func update(_ timeInterval: TimeInterval)
}
