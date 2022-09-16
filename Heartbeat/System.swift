//
//  System.swift
//  Heartbeat
//
//  Created by Joshua Grant on 9/15/22.
//

import Foundation
import Numerics

struct System<T: Real>
{
    var stocks: [Stock<T>] = []
    var flows: [Flow<T>] = []
}
