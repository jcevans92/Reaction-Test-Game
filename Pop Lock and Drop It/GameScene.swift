//
//  GameScene.swift
//  Pop Lock and Drop It
//
//  Created by Jeremy Evans on 11/5/15.
//  Copyright (c) 2015 Jeremy Evans. All rights reserved.
//

import SpriteKit

class GameScene: SKScene {
    
    var lock = SKShapeNode()
    var needle = SKShapeNode()
    var path = UIBezierPath()
    var dot = SKShapeNode()
    
    let zeroAngle: CGFloat = 0.0
    
    var clockWise = Bool()
    var started = false
    var touches = false
    
    var continueMode = Bool()
    var maxLevel = NSUserDefaults.standardUserDefaults().integerForKey("maxLevel")
    
    var level = 1
    var dots = 0
    
    var levelLabel = SKLabelNode()
    var currentScoreLabel = SKLabelNode()
    
    override func didMoveToView(view: SKView) {
        /* Setup your scene here */
        if continueMode {
            level = maxLevel
        }
       layoutGame()
    }
    
    func layoutGame() {
        backgroundColor = UIColor(red: 57/255, green: 204/255, blue: 204/255, alpha: 1)
        
        if level > maxLevel {
            NSUserDefaults.standardUserDefaults().setInteger(level, forKey: "maxLevel")
        }
        
        path = UIBezierPath(arcCenter: CGPoint(x: self.frame.width/2, y: self.frame.height/2), radius: 120, startAngle: zeroAngle, endAngle: zeroAngle + CGFloat(M_PI * 2), clockwise: true)
        
        
        lock = SKShapeNode(path: path.CGPath)
        lock.strokeColor = SKColor.grayColor()
        lock.lineWidth = 40.0
        self.addChild(lock)
        
        needle = SKShapeNode(rectOfSize: CGSize(width: 40.0 - 7.0, height: 7.0), cornerRadius: 3.5)
        needle.fillColor = SKColor.whiteColor()
        needle.position = CGPoint(x: self.frame.width/2, y: self.frame.height/2 + 120.0)
        needle.zRotation = 3.14 / 2
        needle.zPosition = 2.0
        self.addChild(needle)
        
        levelLabel = SKLabelNode(fontNamed: "AvenirNext-Bold")
        levelLabel.position = CGPoint(x: self.frame.width / 2, y: self.frame.height / 2 + self.frame.height / 3)
        levelLabel.fontColor = SKColor(red: 236/255, green: 240/225, blue: 241.255, alpha: 1)
        levelLabel.text = "Level \(level)"
        
        currentScoreLabel = SKLabelNode(fontNamed: "AvenirNext-Bold")
        currentScoreLabel.position = CGPoint(x: self.frame.width / 2, y: self.frame.height / 2)
        currentScoreLabel.fontColor = SKColor(red: 236/255, green: 240/225, blue: 241.255, alpha: 1)
        currentScoreLabel.text = "Tap!"
        
        self.addChild(levelLabel)
        self.addChild(currentScoreLabel)
        
        newDot()
        
        userInteractionEnabled = true
    }
    
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
       /* Called when a touch begins */
        
        if !started {
            currentScoreLabel.text = "\(level - dots)"
            runClockwise()
            started = true
            clockWise = true
        }else {
            dotTouched()
        }
       
    }
    
    func runCounterClockwise() {
        
        let dx = needle.position.x - self.frame.width / 2
        let dy = needle.position.y - self.frame.height / 2
        
        let radian = atan2(dy, dx)
        
        // creates circle used as path for needle to follow
        path = UIBezierPath(arcCenter: CGPoint(x: self.frame.width / 2, y: self.frame.height / 2), radius: 120, startAngle: radian, endAngle: radian + CGFloat(M_PI * 2), clockwise: true)
        
        let run = SKAction.followPath(path.CGPath, asOffset: false, orientToPath: true, speed: 200)
        needle.runAction(SKAction.repeatActionForever(run))
        
        
    }
    
    func runClockwise() {
     
        let dx = needle.position.x - self.frame.width / 2
        let dy = needle.position.y - self.frame.height / 2
        
        let radian = atan2(dy, dx)
        
        // creates circle used as path for needle to follow
        path = UIBezierPath(arcCenter: CGPoint(x: self.frame.width / 2, y: self.frame.height / 2), radius: 120, startAngle: radian, endAngle: radian + CGFloat(M_PI * 2), clockwise: true)
        
        let run = SKAction.followPath(path.CGPath, asOffset: false, orientToPath: true, speed: 200)
        needle.runAction(SKAction.repeatActionForever(run).reversedAction())
        
        
    }
    
    func newDot() {
        dot = SKShapeNode(circleOfRadius: 15.0)
        dot.fillColor = SKColor.blueColor()
        dot.strokeColor = SKColor.clearColor()
        
        let dx = needle.position.x - self.frame.width / 2
        let dy = needle.position.y - self.frame.height / 2
        
        let radian = atan2(dy, dx)
        
        if clockWise {
            let tempAngle = CGFloat.random(radian + 1.0, max: radian + 2.5)
            let tempPath = UIBezierPath(arcCenter: CGPoint(x: self.frame.width / 2, y: self.frame.height / 2), radius: 120, startAngle: tempAngle, endAngle: tempAngle + CGFloat(M_PI * 2), clockwise: true)
            
            dot.position = tempPath.currentPoint
            
        }else {
            let tempAngle = CGFloat.random(radian - 1.0, max: radian - 2.5)
            let tempPath = UIBezierPath(arcCenter: CGPoint(x: self.frame.width / 2, y: self.frame.height / 2), radius: 120, startAngle: tempAngle, endAngle: tempAngle + CGFloat(M_PI * 2), clockwise: true)
            
            dot.position = tempPath.currentPoint
        }
        
        
        self.addChild(dot)
    }
    
    func gameOver() {
        
        userInteractionEnabled = false
        
        needle.removeFromParent()
        
        currentScoreLabel.text = "Fail!"
        
        let actionRed = SKAction.colorizeWithColor(UIColor(red: 149/255, green: 165/255, blue: 166/255, alpha: 1), colorBlendFactor: 1.0, duration: 0.25)
        let actionBack = SKAction.waitForDuration(0.5)
        self.scene?.runAction(SKAction.sequence([actionRed, actionBack]), completion:  { () -> Void in
            self.removeAllChildren()
            self.clockWise = false
            self.dots = 0
            self.level = 0
            self.layoutGame()
        
            
        })
        
    }
    
    func completed() {
        
        userInteractionEnabled = false
        
        needle.removeFromParent()
        
        currentScoreLabel.text = "Won!"
        
        let actionGreen = SKAction.colorizeWithColor(UIColor(red: 46/255, green: 204/255, blue: 113/255, alpha: 1), colorBlendFactor: 1.0, duration: 0.25)
        let actionBack = SKAction.waitForDuration(0.5)
        
        self.scene?.runAction(SKAction.sequence([actionGreen, actionBack]), completion:  { () -> Void in
            self.removeAllChildren()
            self.clockWise = false
            self.dots = 0
            self.level++
            self.layoutGame()
            
            
        })
        
    }
    
    func dotTouched() {
        if touches == true {
            touches = false
            dots++
            updateLabel()
            if dots >= level {
                started = false
                completed()
                return
            }
            dot.removeFromParent()
            newDot()
            
            
            if clockWise {
                runCounterClockwise()
                clockWise = false
            }else {
                runClockwise()
                clockWise = true
            }
        }else {
            started = false
            touches = false
            gameOver()
        }
    }
    
    func updateLabel() {
    
    currentScoreLabel.text = "\(level - dots)"
    
    }
   
    override func update(currentTime: CFTimeInterval) {
        /* Called before each frame is rendered */
        
        if started {
            if needle.intersectsNode(dot) {
                touches = true
            }else {
                if touches == true {
                    if !needle.intersectsNode(dot) {
                        started = false
                        touches = false
                        gameOver()
                    }
                }
            }
            
        }
        
        
    }
}
