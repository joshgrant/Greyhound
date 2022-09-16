//
//  Procedure.swift
//  
//
//  Created by Joshua Grant on 9/15/22.
//

import Foundation
import Numerics

class Procedure<T: Real>
{
    // MARK: - Variables
    
    var uuid = UUID()
    
    /// The stock that's monitored
    var stock: Stock<T>
    
    /// The value of balance that the stock has to be in for the
    /// flows to get executed
    var balanceRange: ClosedRange<T>
    
    /// When the imbalance is met, these flows are executed in order
    var flows: [Flow<T>]
    
    // MARK: - Initialization
    
    init(
        stock: Stock<T>,
        balanceRange: ClosedRange<T>,
        flows: [Flow<T>])
    {
        self.stock = stock
        self.balanceRange = balanceRange
        self.flows = flows
    }
}

extension Procedure
{
    var canExecute: Bool
    {
        balanceRange.contains(stock.balance)
    }
}

extension Procedure: Equatable
{    
    static func == (lhs: Procedure<T>, rhs: Procedure<T>) -> Bool
    {
        lhs.uuid == rhs.uuid
    }
}
