//
//  WelcomeScene.swift
//  FallinDots2
//
//  Created by Joshua Kidd on 3/27/15.
//  Copyright (c) 2015 Joshua Kidd. All rights reserved.
//

import SpriteKit

class WelcomeScene: SKScene {

    override func didMoveToView(view: SKView) {
        backgroundColor = SKColor.whiteColor()
        
        let welcomeLabel = SKLabelNode(fontNamed: "Helvetica-Bold")
        welcomeLabel.name = "welcomeNode"
        welcomeLabel.text = "Tap to start playing"
        welcomeLabel.fontSize = 15
        welcomeLabel.fontColor = SKColor(red: 0.302, green: 0.502, blue: 0.694, alpha: 1)
        welcomeLabel.position = CGPoint(x: CGRectGetMidX(self.frame), y: CGRectGetMidY(self.frame))
        
        addChild(welcomeLabel)
    }
    
    override func touchesBegan(touches: NSSet, withEvent event: UIEvent) {
        let transition = SKTransition.crossFadeWithDuration(0.75)
        let scene = GameScene(size: self.size)
        let gameView = self.view as SKView!
        scene.scaleMode = .AspectFill
        gameView.presentScene(scene, transition: transition)
    }

}