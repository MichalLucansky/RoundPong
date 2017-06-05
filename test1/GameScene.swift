//
//  GameScene.swift
//  test1
//
//  Created by Michal Lučanský on 18.3.17.
//  Copyright © 2017 Michal Lučanský. All rights reserved.
//

import SpriteKit
import GameplayKit

class GameScene: SKScene,SKPhysicsContactDelegate {
    
    var gula = SKSpriteNode()
    var lopta = SKSpriteNode()
    
    let path = UIBezierPath(arcCenter: CGPoint(x: 0, y: 0), radius: CGFloat(340), startAngle: .pi * -2, endAngle: CGFloat(0), clockwise: true)

    var positionOfGula = CGPoint()
    
    var angel = CGFloat()
    var padleMoveArray = [CGFloat]()
    var actualDirection = CGFloat()
    var direction = String()
    let borderCategoryMask : UInt32 = 0x1 << 2
    let borderCollisionMask : UInt32 = 0x1 << 1
    let borderContaktMask : UInt32 = 0x1 << 1
    
    
    override func didMove(to view: SKView) {
        
    
    self.physicsWorld.contactDelegate = self
    angel = .pi * 3 / 2
    addChild(createCircle())
    
        
    gula = childNode(withName: "testik") as! SKSpriteNode
    lopta = childNode(withName: "lopta") as! SKSpriteNode
    
    lopta.physicsBody?.applyImpulse(CGVector(dx: -0.5, dy: -0.5))
   
        
        
          }
    
    
    

    private func padleMoveDirection(){
        
        if padleMoveArray.count == 2{
            let temp = padleMoveArray[0]
            
            let dir =  padleMoveArray[1]
            
            actualDirection = dir - temp
            
            if actualDirection < 0 {
                direction = "UP"
                angel += 0.05
                
                gula.position = calculatePosition(radius: 340, angel: angel)
                gula.zRotation = angel
                
                
            }else if actualDirection > 0{
                direction = "DOWN"
                angel -= 0.05
                
                gula.position = calculatePosition(radius: 340, angel: angel)
               gula.zRotation = angel
                
                
            }else if actualDirection == 0{
                direction = "STOP"
                
                
                
            }
            padleMoveArray.removeFirst()
            
        }
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        
        for touch in touches{
            let location = touch.location(in: self)
            padleMoveArray.append(location.y)
        }
    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        for touch in touches{
            let location = touch.location(in: self)
            padleMoveArray.append(location.y)
        }

    }
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        padleMoveArray.removeAll()
    }
    
    func createCircle() -> SKShapeNode{
        
    
    let circleShape = SKShapeNode()
    
    
        circleShape.path = UIBezierPath(arcCenter: CGPoint(x: 0, y: 0), radius: CGFloat(340), startAngle: CGFloat(0), endAngle: .pi * 2, clockwise: true).cgPath
        
        circleShape.physicsBody = SKPhysicsBody(edgeChainFrom: path.cgPath)
        circleShape.physicsBody?.usesPreciseCollisionDetection = true
        
       circleShape.name = "moveCircleRadius"
        
       circleShape.zPosition = 0
       circleShape.physicsBody?.isDynamic = false
       circleShape.physicsBody?.affectedByGravity = false
       circleShape.physicsBody?.categoryBitMask = borderCategoryMask
       circleShape.physicsBody?.contactTestBitMask = borderContaktMask
       circleShape.physicsBody?.collisionBitMask = borderCollisionMask
       
  
    return circleShape
    
    }
    func calculatePosition (radius: CGFloat, angel: CGFloat) -> CGPoint{
    
        var position = CGPoint()
        
        position.x = radius * cos(angel)
        position.y =  radius * sin(angel)
    
    
        return position
    }
    
    func didBegin(_ contact: SKPhysicsContact) {
        
        if contact.bodyA.node?.name == "jozo" && contact.bodyB.node?.name == "lopta" || contact.bodyA.node?.name == "lopta" && contact.bodyB.node?.name == "jozo"{
        print("kontakt")
            contact.bodyB.node?.removeFromParent()
        }
        
      
        
    }
    
  
    
    
    override func update(_ currentTime: TimeInterval) {
       
        padleMoveDirection()
        
        
    }
}
