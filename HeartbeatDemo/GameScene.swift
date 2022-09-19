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
    private var hunger: SKLabelNode?
    
    lazy var food = FoodSystem()
    lazy var body = BodySystem(
        foodSensor: .init(value: foodSensorValue),
        foodSource: foodSource)
    
    override func didMove(to view: SKView)
    {
        AppDelegate.world.systems.append(body)
        AppDelegate.world.systems.append(food)
        
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

        circle?.position = body.positionSystem.position
        square?.position = food.positionSystem.position
        hunger?.text = "\(body.digestive.stomach.current)"
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?)
    {
        guard let position = touches.first?.location(in: self) else { return }
        food.positionSystem.position = position
    }
    
    func foodSensorValue() -> CGPoint
    {
        food.positionSystem.position
    }
    
    func foodSource() -> Stock
    {
        food.resource
    }
}
