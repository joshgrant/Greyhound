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
    private var circle: SKShapeNode?
    private var square: SKShapeNode?
    private var hunger: SKLabelNode?
    
    override func didMove(to view: SKView)
    {
        hunger = SKLabelNode(text: "Empty")
        hunger?.fontColor = .white
        hunger?.position = .init(x: 100, y: 30)
        addChild(hunger!)
        
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
        print(AppDelegate.world.iterations.current)

//        circle?.position = body.positionSystem.position
//        square?.position = food.positionSystem.position
//        hunger?.text = "\(body.digestive.stomach.current)"
    }
    
//    func foodSensorValue() -> CGPoint
//    {
////        food.positionSystem.position
//    }
//
//    func foodSource() -> Stock
//    {
////        food.resource
//    }
}
