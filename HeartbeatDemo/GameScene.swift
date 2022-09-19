//
//  GameScene.swift
//  HeartbeatDemo
//
//  Created by Joshua Grant on 9/18/22.
//

import SpriteKit
import GameplayKit
import Heartbeat

class CircleSystem: System
{
    // MARK: - Variables
    
    var xIdeal: () -> Double
    var yIdeal: () -> Double = { 300 }
    
    var x: Stock
    var y: Stock
    
    var xPos: Flow
    var yPos: Flow
    var xNeg: Flow
    var yNeg: Flow
    
    var position: CGPoint
    {
        CGPoint(x: x.current, y: y.current)
    }
    
    // MARK: - Initialization
    
    init(xIdeal: @escaping () -> Double)
    {
        self.xIdeal = xIdeal
        
        x = Stock(name: "x", current: 0, ideal: xIdeal, min: 0, max: 1000)
        y = Stock(name: "y", current: 0, ideal: yIdeal, min: 0, max: 1000)
        
        xPos = Flow(name: "xPos", from: .source, to: x, amount: 1, duration: 0.01)
        yPos = Flow(name: "xPos", from: .source, to: y, amount: 1, duration: 0.01)
        xNeg = Flow(name: "xNeg", from: x, to: .sink, amount: 1, duration: 0.01)
        yNeg = Flow(name: "yNeg", from: y, to: .sink, amount: 1, duration: 0.01)
        
        super.init(stocks: [x, y], flows: [xPos, yPos, xNeg, yNeg])
    }
}

class SquareSystem: System
{
    // MARK: - Variables
    
    var x: Stock
    var y: Stock
    
    var xPos: Flow
    var yPos: Flow
    var xNeg: Flow
    var yNeg: Flow
    
    var position: CGPoint
    {
        CGPoint(x: x.current, y: y.current)
    }
    
    func set(position: CGPoint)
    {
        x.current = position.x
        y.current = position.y
    }
    
    // MARK: - Initialization
    
    init()
    {
        x = Stock(name: "x", current: 1000, ideal: { 500 }, min: 600, max: 1000)
        y = Stock(name: "y", current: 1000, ideal: { 500 }, min: 0, max: 1000)
        
        xPos = Flow(name: "xPos", from: .source, to: x, amount: 1, duration: 0.01)
        yPos = Flow(name: "xPos", from: .source, to: y, amount: 1, duration: 0.01)
        xNeg = Flow(name: "xNeg", from: x, to: .sink, amount: 1, duration: 0.01)
        yNeg = Flow(name: "yNeg", from: y, to: .sink, amount: 1, duration: 0.01)
        
        super.init(stocks: [x, y], flows: [xPos, yPos, xNeg, yNeg])
    }
}

class GameScene: SKScene
{
    private var circle: SKShapeNode?
    private var square: SKShapeNode?
    
    func goalX() -> Double
    {
        squareSystem.position.x
    }
    
    lazy var circleSystem = CircleSystem(xIdeal: goalX)
    lazy var squareSystem = SquareSystem()
    
    override func didMove(to view: SKView)
    {
        AppDelegate.world.systems.append(circleSystem)
        AppDelegate.world.systems.append(squareSystem)
        
        circle = SKShapeNode(circleOfRadius: 10)
        circle?.fillColor = .orange
        addChild(circle!)
        
        square = SKShapeNode(rect: CGRect(x: 0, y: 0, width: 10, height: 10))
        square?.fillColor = .green
        addChild(square!)
    }
    
    override func update(_ currentTime: TimeInterval)
    {
        AppDelegate.world.update(currentTime)

        circle?.position = circleSystem.position
        square?.position = squareSystem.position
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?)
    {
        guard let position = touches.first?.location(in: self) else { return }
        
        squareSystem.set(position: position)
    }
}
