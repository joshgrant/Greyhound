//
//  Sensor.swift
//  Heartbeat
//
//  Created by Joshua Grant on 9/19/22.
//

import Foundation

// Because a system is generally self-contained,
// it needs to have a "sensor" that essentially receives
// information from the outside world.
// These sensors have to tap into the "world stream"
// and essentially receive a filtered version of the input...

open class Sensor<T>
{
    // MARK: - Variables
    
    private var _value: () -> T?
    public var value: T? { _value() }
    
    // MARK: - Initialization
    
    public init(value: @escaping () -> T?)
    {
        self._value = value
    }
}
