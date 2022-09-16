//
//  Flow.swift
//  
//
//  Created by Joshua Grant on 9/15/22.
//

import Foundation
import Numerics

public class Flow<T: Real & Codable>: Copyable
{
    // MARK: - Variables
    
    var uuid = UUID()
    
    var from: Stock<T>
    var to: Stock<T>
    
    var amount: T = 1
    var cost: T = 0
    
    // TODO: This is currently ignored
    var duration: TimeInterval = 1
    
    // TODO: This is currently ignored
    var delay: TimeInterval = 0
    
    // MARK: - Initialization
    
    init(
        from: Stock<T>,
        to: Stock<T>,
        amount: T = 1,
        cost: T = 0,
        duration: TimeInterval = 1,
        delay: TimeInterval = 0)
    {
        self.from = from
        self.to = to
        self.amount = amount
        self.cost = cost
        self.duration = duration
        self.delay = delay
    }
    
    // MARK: - Copyable
    
    enum CodingKeys: CodingKey
    {
        case uuid
        case from
        case to
        case amount
        case duration
        case delay
        case cost
    }
    
    public required init(from decoder: Decoder) throws
    {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        uuid = try container.decode(UUID.self, forKey: .uuid)
        from = try container.decode(Stock<T>.self, forKey: .from)
        to = try container.decode(Stock<T>.self, forKey: .to)
        amount = try container.decode(T.self, forKey: .amount)
        cost = try container.decode(T.self, forKey: .cost)
        duration = try container.decode(TimeInterval.self, forKey: .duration)
        delay = try container.decode(TimeInterval.self, forKey: .delay)
    }
    
    public func encode(to encoder: Encoder) throws
    {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(uuid, forKey: .uuid)
        try container.encode(from, forKey: .from)
        try container.encode(to, forKey: .to)
        try container.encode(amount, forKey: .amount)
        try container.encode(cost, forKey: .cost)
        try container.encode(duration, forKey: .duration)
        try container.encode(delay, forKey: .delay)
    }
}

extension Flow: Equatable
{
    public static func == (lhs: Flow<T>, rhs: Flow<T>) -> Bool
    {
        lhs.uuid == rhs.uuid
    }
}

extension Flow
{
    func run()
    {
        var amountToSubtract = amount
        
        if from.current - amountToSubtract < from.min
        {
            amountToSubtract = from.current
        }
        
        if to.current + amountToSubtract > to.max
        {
            amountToSubtract = to.max - to.current
        }
        
        from.current -= amountToSubtract
        to.current += amountToSubtract
    }
}
