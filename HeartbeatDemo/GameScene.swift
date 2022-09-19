//
//  GameScene.swift
//  HeartbeatDemo
//
//  Created by Joshua Grant on 9/18/22.
//

import SpriteKit
import GameplayKit
import Heartbeat

class GameScene: SKScene
{
    private var circle: SKShapeNode?
    private var square: SKShapeNode?
    
    func goalX() -> Double
    {
        squareSystem.stocks["x"]?.current ?? 0
    }
    
    func goalY() -> Double
    {
        return 300
    }
    
    private lazy var circleSystem: System =
    {
        let x = Stock(name: "x", current: 0, ideal: goalX, min: 0, max: 1000)
        let y = Stock(name: "y", current: 0, ideal: goalY, min: 0, max: 1000)
        
        let moveX = Flow(name: "moveX", from: .source, to: x, amount: 1, duration: 0.01)
        let moveY = Flow(name: "moveY", from: .source, to: y, amount: 1, duration: 0.01)
        
        let moveXNeg = Flow(name: "moveXNeg", from: x, to: .sink, amount: 1, duration: 0.01)
        let moveYNeg = Flow(name: "moveYNeg", from: y, to:.sink, amount: 1, duration: 0.01)
        
        return System(stocks: [x, y], flows: [moveX, moveY, moveXNeg, moveYNeg])
    }()
    
    private lazy var squareSystem: System =
    {
        let x = Stock(name: "x", current: 1000, ideal: { 500 }, min: 600, max: 1000)
        let y = Stock(name: "y", current: 1000, ideal: { 500 }, min: 0, max: 1000)
        
        let moveX = Flow(name: "moveX", from: .source, to: x, amount: 1, duration: 0.01)
        let moveY = Flow(name: "moveY", from: .source, to: y, amount: 1, duration: 0.01)
        
        let moveXNeg = Flow(name: "moveXNeg", from: x, to: .sink, amount: 1, duration: 0.01)
        let moveYNeg = Flow(name: "moveYNeg", from: y, to:.sink, amount: 1, duration: 0.01)
        
        return System(stocks: [x, y], flows: [moveX, moveY, moveXNeg, moveYNeg])
    }()
    
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

        circle?.position.x = CGFloat(circleSystem.stocks["x"]?.current ?? 0)
        circle?.position.y = CGFloat(circleSystem.stocks["y"]?.current ?? 0)
        
        square?.position.x = CGFloat(squareSystem.stocks["x"]?.current ?? 0)
        square?.position.y = CGFloat(squareSystem.stocks["y"]?.current ?? 0)
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?)
    {
        guard let position = touches.first?.location(in: self) else { return }
        
        squareSystem.stocks["x"]?.current = position.x
        squareSystem.stocks["y"]?.current = position.y
    }
}
