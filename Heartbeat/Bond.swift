//
//  Bond.swift
//  Heartbeat
//
//  Created by Joshua Grant on 9/19/22.
//

import Foundation

public class Bond
{
    // MARK: - Variables
    
    public var lhs: Stock
    public var rhs: Stock
    
    // MARK: - Initialization
    
    public init(lhs: Stock, rhs: Stock)
    {
        self.lhs = lhs
        self.rhs = rhs
    }
    
    // MARK: - Functions
    
    public var delta: Double
    {
        lhs.delta + rhs.delta
    }
    
    public var maximum: Double
    {
        lhs.maximum + rhs.maximum
    }
    
    public var balance: Double
    {
        1 - abs(delta) / maximum
    }
}
