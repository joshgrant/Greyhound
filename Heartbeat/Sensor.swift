////
////  Sensor.swift
////  Heartbeat
////
////  Created by Joshua Grant on 9/19/22.
////
//
//import Foundation
//
//// Because a system is generally self-contained,
//// it needs to have a "sensor" that essentially receives
//// information from the outside world.
//// These sensors have to tap into the "world stream"
//// and essentially receive a filtered version of the input...
//
//open class Input<T>
//{
//    // MARK: - Variables
//    
//    private var _source: () -> T?
//    public var source: T? { _source() }
//    
//    // MARK: - Initialization
//    
//    public init(source: @escaping () -> T?)
//    {
//        self._source = source
//    }
//}
