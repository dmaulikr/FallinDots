//
//  Dot.swift
//  FallinDots2
//
//  Created by Joshua Kidd on 3/16/15.
//  Copyright (c) 2015 Joshua Kidd. All rights reserved.
//

import SpriteKit

class Dot: SKShapeNode {
    
    override init() {
        super.init()
        var dotPath: CGMutablePathRef = CGPathCreateMutable()
        CGPathAddArc(dotPath, nil, 0, 0, 20, 0, CGFloat(M_PI)*2, true)
        
        self.name = "DOT_NODE"
        self.position = CGPointMake(CGRectGetMinX(self.frame) + 20, CGRectGetMaxY(self.frame) - 100)
        self.fillColor = SKColor.whiteColor()
        self.physicsBody = SKPhysicsBody(circleOfRadius: 20)
        self.physicsBody!.mass = 0.75
        self.physicsBody!.friction = 12.5
        self.physicsBody!.affectedByGravity = true
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func destroy() {
        let scaleAction = SKAction.scaleTo(25.0, duration: 0.45)
        let fadeAction = SKAction.fadeOutWithDuration(0.45)
        let removeAction = SKAction.removeFromParent()
        let removeSequence = [scaleAction, removeAction]
        self.runAction(fadeAction)
        self.runAction(SKAction.sequence(removeSequence))
    }
    
}
