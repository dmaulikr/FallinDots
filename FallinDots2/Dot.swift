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
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    internal func destroy() {
        let scaleAction = SKAction.scaleTo(25.0, duration: 0.45)
        let fadeAction = SKAction.fadeOutWithDuration(0.45)
        let removeAction = SKAction.removeFromParent()
        let removeSequence = [scaleAction, removeAction]
        self.runAction(fadeAction)
        self.runAction(SKAction.sequence(removeSequence))
    }
}
