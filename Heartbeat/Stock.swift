//
//  Stock.swift
//  
//
//  Created by Joshua Grant on 9/15/22.
//

import Foundation

// TODO: Is a Stock really just a matrix with named fields?
public struct Stock<T>
{
    var current: T
    var ideal: T
    
    var min: T
    var max: T
    
    // These are like the "body"
    var inflows: [Flow] = []
    var outflows: [Flow] = []
}
