//
//  Stock.swift
//  
//
//  Created by Joshua Grant on 9/15/22.
//

import Foundation
import Numerics

public class Stock<T: Real & Codable>: Copyable
{
    // MARK: - Variables
    
    var uuid = UUID()
    
    var current: T
    var ideal: T
    
    var min: T
    var max: T
    
    var unit: Unit
    
    // MARK: - Initialization
    
    init(
        current: T,
        ideal: T,
        min: T,
        max: T,
        unit: Unit = UnitEnergy.joules)
    {
        self.current = current
        self.ideal = ideal
        self.min = min
        self.max = max
        self.unit = unit
    }
    
    // MARK: - Copyable
    
    enum CodingKeys: CodingKey
    {
        case uuid
        case current
        case ideal
        case min
        case max
        case unit
    }
    
    public required init(from decoder: Decoder) throws
    {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        uuid = try container.decode(UUID.self, forKey: .uuid)
        current = try container.decode(T.self, forKey: .current)
        ideal = try container.decode(T.self, forKey: .ideal)
        min = try container.decode(T.self, forKey: .min)
        max = try container.decode(T.self, forKey: .max)
//        unit = try container.decode(Unit.self, forKey: .unit)
        unit = UnitArea.acres
        
    }
    
    public func encode(to encoder: Encoder) throws
    {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(uuid, forKey: .uuid)
        try container.encode(current, forKey: .current)
        try container.encode(ideal, forKey: .ideal)
        try container.encode(min, forKey: .min)
        try container.encode(max, forKey: .max)
//        try container.encode(unit, forKey: .unit)
    }
}

extension Stock
{
    var balance: T {
        T.percentDelta(
            a: current,
            b: ideal,
            minimum: min,
            maximum: max)
    }
}

extension Stock: Equatable
{
    public static func == (lhs: Stock<T>, rhs: Stock<T>) -> Bool
    {
        lhs.uuid == rhs.uuid
    }
}
