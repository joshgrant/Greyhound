//
//  GameScene.swift
//  Greyhound
//
//  Created by Joshua Grant on 9/22/22.
//

import SpriteKit
import GameplayKit
import Heartbeat

class GameScene: SKScene
{
    // MARK: - Initialization
    
    override func didMove(to view: SKView)
    {
        // Box
        let boxRect = CGRect(x: 500, y: 500, width: 20, height: 20)
        let box = SKShapeNode(rect: boxRect)
        let boxBody = SKPhysicsBody(rectangleOf: boxRect.size)
        box.physicsBody = boxBody
        addChild(box)
        
        
        // Ground
        let groundRect = CGRect(x: 0, y: 20, width: 1000, height: 10)
        let ground = SKShapeNode(rect: groundRect)
        let groundBody = SKPhysicsBody(rectangleOf: groundRect.size)
        groundBody.isDynamic = false
        ground.physicsBody = groundBody
        addChild(ground)
    }
}
