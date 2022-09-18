//
//  ClassStock3D.swift
//  Heartbeat
//
//  Created by Joshua Grant on 9/18/22.
//

import Foundation
import Spatial

protocol Stock: AnyObject, CustomStringConvertible, Equatable
{
    associatedtype T: Comparable
    
    var current: T { get }
    var ideal: T { get set }
    var min: T { get set }
    var max: T { get set }
    
    var unit: Unit? { get set }
    
    var balance: Double { get }
    var sign: Sign { get }
    
    func remove(amount: T)
    func add(amount: T)
}

extension Stock
{
    var sign: Sign
    {
        if current > ideal
        {
            return .positive
        }
        else if current < ideal
        {
            return .negative
        }
        else
        {
            return .neither
        }
    }
}
