//
//  ViewController.swift
//  Greyhound
//
//  Created by Joshua Grant on 9/22/22.
//

import Cocoa
import SpriteKit
import GameplayKit

class ViewController: NSViewController
{
    @IBOutlet var skView: SKView!
    
    override func viewDidLoad()
    {
        super.viewDidLoad()

        if let view = self.skView
        {
            let scene = GameScene()
            scene.scaleMode = .resizeFill
            view.presentScene(scene)
            
            view.ignoresSiblingOrder = true
            
            view.showsFPS = true
            view.showsNodeCount = true
        }
    }
}
