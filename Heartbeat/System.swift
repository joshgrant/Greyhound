//
//  System.swift
//  Client
//
//  Created by Joshua Grant on 9/16/22.
//

import Foundation

public protocol System: AnyObject, CustomStringConvertible
{
    associatedtype S: Stock
    associatedtype F: Flow
    
    var stocks: [S] { get set }
    var flows: [F] { get set }
    
    func update(_ timeInterval: TimeInterval)
}
