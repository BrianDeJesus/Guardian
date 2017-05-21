//
//  GameScene.swift
//  Guardian
//
//  Created by Brian  Dejesus on 5/20/17.
//  Copyright © 2017 Brian  Dejesus. All rights reserved.
//

import SpriteKit
import GameplayKit

class GameScene: SKScene {
    
    var ball = SKSpriteNode()
    var topPad = SKSpriteNode()
    var bottomPad = SKSpriteNode()
    var botL = SKLabelNode()
    var endS = SKLabelNode()
    var score = 0
    var button = UIButton()
    
    
    override func didMove(to view: SKView) {
        //Assign Child Nodes
        botL = self.childNode(withName: "bottomLabel") as! SKLabelNode
        endS = self.childNode(withName: "finalScore") as! SKLabelNode
        
        ball = self.childNode(withName: "ball") as! SKSpriteNode
        topPad = self.childNode(withName: "topPad") as! SKSpriteNode
        bottomPad = self.childNode(withName: "bottomPad") as! SKSpriteNode
        
        //ball.physicsBody?.isResting = true
        let border = SKPhysicsBody(edgeLoopFrom: self.frame)
        
        border.friction = 0
        border.restitution = 1
        
        self.physicsBody = border
        startGame()
    }
    
    func restartButtonPressed(sender: AnyObject){
        if let scene = GameScene(fileNamed: "GameScene"){
            scene.scaleMode = .aspectFill
            view?.presentScene(scene)
            button.isHidden = true
        }
        
    }
    
    func startGame(){
        score = 0
        ball.physicsBody?.isResting = false
        ball.physicsBody?.applyImpulse(CGVector(dx: 75, dy: 70))
        endS.isHidden = true
        botL.text = String(score)
    }
    
    func gameOver(){
        endS.text = "Game Over. Score: \(score)"
        endS.isHidden = false
        ball.physicsBody?.linearDamping += 2
        createButton(button:button)
        view?.addSubview(button)
    }
    
    func createButton(button: UIButton){
        button.setTitle("Play Again", for: .normal)
        button.frame = CGRect(x: self.frame.size.width/7, y: self.frame.size.height/7, width: 100, height: 50)
        button.layer.borderWidth = 2
        button.backgroundColor = UIColor.darkGray
        button.layer.cornerRadius = 18
        button.setTitleShadowColor(UIColor.darkText, for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 20)
        button.setTitleColor(UIColor.cyan, for: .normal)
        button.addTarget(self, action: #selector(GameScene.restartButtonPressed(sender:)), for: UIControlEvents.touchUpInside)
        
        view?.addSubview(button)
    }
    
    
    func point(){
        ball.position = CGPoint(x: 0, y: 0)
        ball.physicsBody?.velocity = CGVector(dx: 0, dy: 0)
        bottomPad.size.width -= 10
        ball.physicsBody?.applyImpulse(CGVector(dx: 90, dy: 90))
        score += 1
        botL.text = String(score)
    }
    
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        for touch in touches {
            let location = touch.location(in: self)
            bottomPad.run(SKAction.moveTo(x: location.x, duration: 0.3))
        }
    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        for touch in touches {
            let location = touch.location(in: self)
            bottomPad.run(SKAction.moveTo(x: location.x, duration: 0.3))
        }
        
    }
    
    override func update(_ currentTime: TimeInterval) {
        // Called before each frame is rendered
        topPad.run(SKAction.moveTo(x: ball.position.x, duration: 0.3))
        
        if ball.position.y < bottomPad.position.y - 50 {
            gameOver()
        }
        else if ball.position.y > topPad.position.y + 50{
            point()
        }
        
    }
}

