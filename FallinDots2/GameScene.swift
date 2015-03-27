//
//  GameScene.swift
//  FallinDots2
//
//  Created by Joshua Kidd on 3/13/15.
//  Copyright (c) 2015 Joshua Kidd. All rights reserved.
//

import SpriteKit

extension SKColor {
    convenience init(rgba: String) {
        var red:    CGFloat = 0.0
        var green:  CGFloat = 0.0
        var blue:   CGFloat = 0.0
        var alpha:  CGFloat = 1.0
        
        if rgba.hasPrefix("#") {
            let index = advance(rgba.startIndex, 1)
            let hex = rgba.substringFromIndex(index)
            let scanner = NSScanner(string: hex)
            var hexValue: CUnsignedLongLong = 0
            if scanner.scanHexLongLong(&hexValue) {
                switch(countElements(hex)) {
                case 3:
                    red = CGFloat((hexValue & 0xF00) >> 8)      / 15.0
                    green = CGFloat((hexValue & 0x0F0) >> 4)    / 15.0
                    blue = CGFloat(hexValue & 0x00F)            / 15.0
                case 4:
                    red = CGFloat((hexValue & 0xF000) >> 12)    / 15.0
                    green = CGFloat((hexValue & 0x0F00) >> 8)   / 15.0
                    blue = CGFloat((hexValue & 0x00F0) >> 4)     / 15.0
                    alpha = CGFloat(hexValue & 0x000F)          / 15.0
                case 6:
                    red = CGFloat((hexValue & 0xFF0000) >> 16)     / 255.0
                    green = CGFloat((hexValue & 0x00FF00) >> 8)    / 255.0
                    blue = CGFloat(hexValue & 0x0000F)             / 255.0
                case 8:
                    red = CGFloat((hexValue & 0xFF000000) >> 24)      / 255.0
                    green = CGFloat((hexValue & 0x00FF0000) >> 16)    / 255.0
                    blue = CGFloat((hexValue & 0x0000FF00) >> 8)      / 255.0
                    alpha = CGFloat(hexValue & 0x000000FF)            / 255.0
                default:
                    print("Invalid RGB string, number of characters after '#' should be either 3, 4, 6, or 8")
                }
            }else{
                println("Scan hex error")
            }
            
        }else{
            print("Invalid RGB string, missing '#' as prefix")
        }
        
        self.init(red: red, green: green, blue: blue, alpha: alpha)
    }
}

class GameScene: SKScene {
    
    var isUiSetup: Bool = false
    var timer = NSTimer()
    var dots:[Dot] = []
    let paddingSpace = 5
    
    override func didMoveToView(view: SKView) {
        backgroundColor = SKColor(rgba: "#000000")
        physicsWorld.gravity = CGVector(dx: 0.0, dy: (-3.0/1.5));
        setupUI()
        createDot()
    }
    
    override func touchesBegan(touches: NSSet, withEvent event: UIEvent) {
        for touch: AnyObject in touches {
            let location = touch.locationInNode(self)
            let node = self.nodeAtPoint(location)
            if node.name == "DOT_NODE" {
                
            }
        }
    }
    
    override func update(currentTime: NSTimeInterval) {
        for dot in dots {
            if dot.position.y < CGRectGetMinY(self.frame) {
                println("Dot at the bottom")
                dot.destroy()
            }
        }
    }
    
    func createDot() {
        var dotPath: CGMutablePathRef = CGPathCreateMutable()
        CGPathAddArc(dotPath, nil, 0, 0, 20, 0, CGFloat(M_PI)*2, true)
//        var newDot: = SKShapeNode(path: dotPath)
        var newDot = Dot(path: dotPath)
        var size = 20
        var randXPos = CGFloat(arc4random_uniform(UInt32(CGRectGetMinX(self.frame)) + UInt32(CGRectGetMaxX(self.frame))))
        newDot.name = "DOT_NODE"
        newDot.position = CGPointMake(randXPos, CGRectGetMaxY(self.frame) + 20 - CGFloat(paddingSpace))
//        newDot.position = CGPointMake(CGRectGetMinX(self.frame) + 20 + CGFloat(paddingSpace), CGRectGetMaxY(self.frame) + 20 - CGFloat(paddingSpace))
//        newDot.position = randomPosition(size)
        newDot.fillColor = SKColor.whiteColor()
        newDot.physicsBody = SKPhysicsBody(circleOfRadius: 20)
        newDot.physicsBody!.mass = 0.75
        newDot.physicsBody!.friction = 12.5
        newDot.physicsBody!.affectedByGravity = true
        dots.append(newDot)
        addChild(newDot)
    }
    
    func setupUI() {
        let scoreLabel = SKLabelNode(fontNamed: "Helvetica-Bold")
        scoreLabel.color = SKColor(rgba: "#FFFFFF")
        scoreLabel.fontSize = 65
        scoreLabel.text = "0"
        scoreLabel.position = CGPoint(x: CGRectGetMidX(self.frame), y: CGRectGetMidY(self.frame))
        
        addChild(scoreLabel)
    }
    
    func randomPosition(size:Int)->CGPoint {
        var randXPos = CGFloat(arc4random_uniform(UInt32(CGRectGetMinX(self.frame))) + UInt32(CGRectGetMaxX(self.frame)))
        return CGPointMake(randXPos, CGRectGetMaxY(self.frame) + CGFloat(size))
    }
    
}
