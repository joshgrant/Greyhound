//
//  App.swift
//  Client
//
//  Created by Joshua Grant on 9/16/22.
//

import Foundation

struct App<T>
{
    var state: T
    var update: (T) -> T
    var display: (T) -> Void
    var shouldExit: (T) -> Bool
    
    mutating func run()
    {
        while !shouldExit(state)
        {
            state = update(state)
            display(state)
        }
        
        print("Goodbye!")
    }
}
