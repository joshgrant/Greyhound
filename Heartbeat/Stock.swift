//
//  ClassStock3D.swift
//  Heartbeat
//
//  Created by Joshua Grant on 9/18/22.
//

import Foundation

public protocol Stock: AnyObject, CustomStringConvertible, Equatable
{
    associatedtype T: Comparable
    
    var name: String { get }
    
    var current: T { get }
    var ideal: T { get set }
    var min: T { get set }
    var max: T { get set }
    
    var unit: Unit? { get set }
    
    var balance: Double { get }
    var sign: ComparisonResult { get }
}

public extension Stock
{
    var sign: ComparisonResult
    {
        if current > ideal
        {
            return .orderedAscending
        }
        else if current < ideal
        {
            return .orderedDescending
        }
        else
        {
            return .orderedSame
        }
    }
}
