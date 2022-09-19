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
    private var shape: SKShapeNode?
    
    private var coordinateSystem: System1D =
    {
        let x = Stock1D(name: "x", current: 0, ideal: 300, min: 0, max: 300)
        let y = Stock1D(name: "y", current: 0, ideal: 100, min: 0, max: 100)
        
        let moveX = Flow1D(name: "moveX", from: .source, to: x, amount: 1, duration: 0.01)
        let moveY = Flow1D(name: "moveY", from: .source, to: y, amount: 1, duration: 0.01)
        
        return System1D(stocks: [x, y], flows: [moveX, moveY])
    }()
    
    override func didMove(to view: SKView)
    {
        AppDelegate.world.systems.append(coordinateSystem)
        
        shape = SKShapeNode(circleOfRadius: 10)
        addChild(shape!)
    }
    
    override func update(_ currentTime: TimeInterval)
    {
        AppDelegate.world.update(currentTime)
        shape?.position.x = CGFloat(coordinateSystem.stocks.first(where: { $0.name == "x" })?.current ?? 0)
        shape?.position.y = CGFloat(coordinateSystem.stocks.first(where: { $0.name == "y" })?.current ?? 0)
    }
}
