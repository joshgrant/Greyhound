//
//  System.swift
//  Client
//
//  Created by Joshua Grant on 9/16/22.
//

import Foundation

protocol System: AnyObject, CustomStringConvertible
{
    associatedtype S: Stock
    associatedtype F: Flow
    
    var stocks: [S] { get set }
    var flows: [F] { get set }
}
