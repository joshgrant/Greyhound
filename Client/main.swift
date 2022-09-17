//
//  main.swift
//  Client
//
//  Created by Joshua Grant on 9/15/22.
//

import Foundation

let stockA = Stock(current: 100, ideal: 100, minimum: 0, maximum: 100)
let stockB = Stock(current: 0, ideal: 100, minimum: 0, maximum: 100)
let flow = Flow(from: stockA, to: stockB, amount: 1)

let world = World<Double>(system: .init(stocks: [stockA, stockB], flows: [flow]), iterations: 0)
var app = App<World>(
    state: world,
    update: World.update,
    display: World.display,
    shouldExit: World.shouldExit)
app.run()
