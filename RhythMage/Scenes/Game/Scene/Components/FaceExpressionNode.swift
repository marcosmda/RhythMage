//
//  FaceExpressionNode.swift
//  RhythMage
//
//  Created by Lucas Frazão on 01/11/21.
//

import SpriteKit

enum FacePosition {
    case left
    case middle
    case right
}

class FaceExpressionNode: SKNode {

    //MARK: - Timers for Internal Testing (!!!)
    var hitTimer: Timer?
    var circleInt = 0
    
    var circle = SKSpriteNode()
    var defaultHeight = 50
    var height: Int
    
    internal var positions: FacePosition
    
    init(height: Int, position: FacePosition) {
        self.height = height
        self.positions = position
        super.init()
        setupNode()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupNode() {
        addBody()
    
        switch positions {
        case .left:
            circle = SKSpriteNode(imageNamed: "leftFaceCircle")
            setupImage(with: .left, from: circle)
            break
        case .middle:
            circle = SKSpriteNode(imageNamed: "middleFaceCircle")
            setupImage(with: .middle, from: circle)
            break
        case .right:
            circle = SKSpriteNode(imageNamed: "rightFaceCircle")
            setupImage(with: .right, from: circle)
            break
        }
        
        self.addChild(circle)
     
    }
    
    func addBody() {
        let size = CGSize(width: defaultHeight, height: height)
        let position = CGPoint(x: self.position.x, y: self.position.y + CGFloat(height/2))
        let body = SKPhysicsBody(rectangleOf: size, center: position)
        body.usesPreciseCollisionDetection = true
        body.affectedByGravity = false
        body.restitution = 0
        body.friction = 0
        body.linearDamping = 0
        
        body.categoryBitMask = GameSceneCattegoryTypes.tileOrb.rawValue
        body.contactTestBitMask = GameSceneCattegoryTypes.faceExpression.rawValue
        body.collisionBitMask = 0
        
        self.physicsBody = body
    }
    
    func setupImage(with position: FacePosition, from node: SKSpriteNode) {
        
        var image = SKSpriteNode()
        
        switch position {
        case .left:
            image = SKSpriteNode(imageNamed: "leftFaceExpression")
            break
        case .middle:
            image = SKSpriteNode(imageNamed: "middleFaceExpression")
            break
        case .right:
            image = SKSpriteNode(imageNamed: "rightFaceExpression")
            break
        }
        
        node.addChild(image)
        
        image.position.x = node.position.x
        image.position.y = node.position.y
        image.size.height = node.size.height / 1.5
        
    }
    
    //MARK: - Hit Animation
    @objc func setupHitAnimation() {
        
        var animation = SKSpriteNode()
        
        switch positions {
        case .left:
            animation = SKSpriteNode(imageNamed: "leftHitEffect")
            break
        case .middle:
            animation = SKSpriteNode(imageNamed: "middleHitEffect")
            break
        case .right:
            animation = SKSpriteNode(imageNamed: "rightHitEffect")
            break
        }
        
        circle.addChild(animation)
        
        animation.zPosition = -1000
        animation.alpha = 0.0
        animation.position.x = circle.position.x
        animation.position.y = circle.position.y
        animation.size.height = animation.size.height / 4
        animation.size.width = animation.size.width / 4
        
        //MARK: - Action Sequences Setup
        let rotation = SKAction.rotate(toAngle: 270, duration: 0.8)
        let fadeIn = SKAction.fadeIn(withDuration: 0.6)
        let scaleUp = SKAction.scale(by: 3.5, duration: 0.8)
        scaleUp.timingFunction = { t in
            return t*t*t*t*t
        }
        
        let fadeOut = SKAction.fadeOut(withDuration: 0.6)
        let scaleDown = SKAction.scale(by: -3.5, duration: 0.8)
        scaleDown.timingFunction = { t in
            return t*t*t*t*t
        }
        
        let fadeInAndScaleUp = SKAction.group([fadeIn, scaleUp])
        let scaleDownAndFadeOut = SKAction.group([scaleDown, fadeOut])
        animation.run(SKAction.sequence([fadeInAndScaleUp, rotation, scaleDownAndFadeOut])) {
            animation.removeFromParent()
        }
        
    }
    
    
    
}
