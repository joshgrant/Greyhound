//
//  Source.swift
//  
//
//  Created by Joshua Grant on 9/15/22.
//

import Numerics

struct Vector<T: Real>
{
    var values: [T]
    
    init(_ values: [T])
    {
        self.values = values
    }
    
    init(_ values: T...)
    {
        self.values = values
    }
}

extension Vector where T: Real
{
    subscript(_ row: Int) -> T
    {
        return values[row]
    }
    
    var x: T?
    {
        guard values.count > 0 else { return nil }
        return values[0]
    }
    
    var y: T?
    {
        guard values.count > 1 else { return nil }
        return values[1]
    }
    
    var z: T?
    {
        guard values.count > 2 else { return nil }
        return values[2]
    }
    
    var w: T?
    {
        guard values.count > 3 else { return nil }
        return values[3]
    }
}

extension Vector: Equatable { }

// MARK: - Operators

infix operator ∆
func ∆<T: Real>(lhs: Vector<T>, rhs: Vector<T>) -> T
{
    let values = zip(lhs.values, rhs.values)
    let deltas = values.map(T.delta)
    let sum = deltas.reduce(0) { $0 + $1 * $1 }
    return sqrt(sum)
}

func -<T: Real>(lhs: Vector<T>, rhs: Vector<T>) -> Vector<T>
{
    let values = zip(lhs.values, rhs.values)
    let result = values.map(-)
    return Vector<T>(result)
}

func +<T: Real>(lhs: Vector<T>, rhs: Vector<T>) -> Vector<T>
{
    let values = zip(lhs.values, rhs.values)
    let result = values.map(+)
    return Vector<T>(result)
}
