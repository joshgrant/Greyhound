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
    
    func goalX() -> Double { squareSystem.position.x }
    
    lazy var circleSystem = PositionSystem(x: 0, y: 0, xIdeal: goalX, yIdeal: { 300 })
    lazy var squareSystem = PositionSystem(x: 1000, y: 1000, xIdeal: { 500 }, yIdeal: { 500 })
    
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
        squareSystem.position = position
    }
}
