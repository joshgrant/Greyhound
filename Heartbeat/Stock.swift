//
//  Stock.swift
//  
//
//  Created by Joshua Grant on 9/15/22.
//

import Foundation

public struct Stock<T>
{
    var current: T
    var ideal: T
    
    var min: T
    var max: T
    
    var unit: Unit
}
