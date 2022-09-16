//
//  System.swift
//  Heartbeat
//
//  Created by Joshua Grant on 9/15/22.
//

import Foundation
import Numerics

class System<T: Real>
{
    var stocks: [Stock<T>] = []
    var procedures: [Procedure<T>] = []
    var flows: [Flow<T>] = []
}

extension System
{
    var leastBalanced: Stock<T>?
    {
        var stock: Stock<T>?
        var balance = T.infinity
        
        for s in stocks
        {
            let b = s.balance
            
            if b < balance {
                balance = b
                stock = s
            }
        }
        
        return stock
    }
    
    func availableProcedure(for stock: Stock<T>) -> Procedure<T>?
    {
        for procedure in procedures
        {
            if procedure.stock == stock && procedure.canExecute
            {
                return procedure
            }
        }
        
        return nil
    }
}
