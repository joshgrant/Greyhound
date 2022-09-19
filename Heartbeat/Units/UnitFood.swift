//
//  UnitFood.swift
//  Heartbeat
//
//  Created by Joshua Grant on 9/19/22.
//

import Foundation

public class UnitFood: Dimension
{
    public override class func baseUnit() -> Self
    {
        return Self(symbol: "food")
    }
    
    public static var unit: Dimension
    {
        return baseUnit()
    }
}
