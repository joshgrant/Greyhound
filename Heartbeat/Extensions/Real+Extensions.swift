//
//  Real+Extensions.swift
//  Heartbeat
//
//  Created by Joshua Grant on 9/15/22.
//

import Numerics

extension Real
{
    static func delta(_ a: Self?, _ b: Self?) -> Self
    {
        guard let a = a, let b = b else { return .zero }
        return abs(b - a)
    }
}

func -<T: Real>(lhs: T?, rhs: T?) -> T?
{
    guard let lhs = lhs, let rhs = rhs else { return nil }
    return lhs - rhs
}
