//
//  Dimension.swift
//  Heartbeat
//
//  Created by Joshua Grant on 9/23/22.
//

import Foundation

public enum Dimension
{
    case volume
    case length
    case energy
    case area
    case utility
    case system
    
    var baseUnit: Unit
    {
        switch self
        {
        case .volume: return .liters
        case .length: return .meters
        case .energy: return .joules
        case .area: return .metersSquared
        case .utility: return .any
        case .system: return .any
        }
    }
}

