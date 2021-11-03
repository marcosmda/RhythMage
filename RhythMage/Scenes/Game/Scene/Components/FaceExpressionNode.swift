//
//  FaceExpressionNode.swift
//  RhythMage
//
//  Created by Lucas Frazão on 01/11/21.
//

import SpriteKit

struct FaceIndicator {
    var defaultTexture: String
    var activeTexture: String {
        return "\(defaultTexture)Active"
    }
    
    func setupNode() -> SKSpriteNode {
        let node = SKSpriteNode(imageNamed: defaultTexture)
        return node
    }
    
}

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
    let defaultHeight = 50
    var height: Int
    
    var isCircleActive: Bool = true
    var animationNode = SKSpriteNode()
    
    internal var positions: FacePosition
    
    //MARK: Animations
    lazy var bigSize = CGSize(width: Double(defaultHeight)*2, height: Double(defaultHeight)*2)
    lazy var smallSize = CGSize(width: Double(defaultHeight)*0.3, height: Double(defaultHeight)*0.3)
    
    let rotation = SKAction.rotate(toAngle: 270, duration: 0.3)
    
    let fadeIn = SKAction.fadeIn(withDuration: 0.3)
    lazy var scaleUp = SKAction.scale(to: bigSize, duration: 0.3)
    
    let fadeOut = SKAction.fadeOut(withDuration: 0.3)
    lazy var scaleDown = SKAction.scale(to: smallSize, duration: 0.3)
    
    let hapticAction = SKAction.customAction(withDuration: 0) { _, _ in
        haptic.setupImpactHaptic(style: .heavy)
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
            haptic.setupImpactHaptic(style: .light)
        }
    }
    
    lazy var fadeInAndScaleUp = SKAction.group([scaleUp, fadeIn, rotation])
    lazy var scaleDownAndFadeOut = SKAction.group([rotation, scaleDown, fadeOut])
    
    
    let leftFaceIndicator = FaceIndicator(defaultTexture: "leftFaceCircle")
    let rightFaceIndicator = FaceIndicator(defaultTexture: "rightFaceCircle")
    let middleFaceIndicator = FaceIndicator(defaultTexture: "middleFaceCircle")
    
    init(height: Int, position: FacePosition) {
        self.height = height
        self.positions = position
        super.init()
        setupNode()
        setAnimationForNode()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupNode() {
        addBody()
    
        switch positions {
        case .left:
            circle = leftFaceIndicator.setupNode()
            setupImage(with: .left, from: circle)
//            hitTimer = Timer.scheduledTimer(timeInterval: 4, target: self, selector: #selector(setupHitAnimation), userInfo: nil, repeats: true)
            break
        case .middle:
            circle = middleFaceIndicator.setupNode()
            setupImage(with: .middle, from: circle)
//            setCircleAsActive(with: true)
            break
        case .right:
            circle = rightFaceIndicator.setupNode()
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
        
        body.categoryBitMask = GameSceneCattegoryTypes.faceExpression.rawValue
        body.contactTestBitMask = GameSceneCattegoryTypes.tileOrb.rawValue
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
    
    
    
}

//MARK: - Hit Animation
extension FaceExpressionNode {

    func setAnimationForNode() {
        
        switch positions {
        case .left:
            animationNode = SKSpriteNode(imageNamed: "leftHitEffect")
            break
        case .middle:
            animationNode = SKSpriteNode(imageNamed: "middleHitEffect")
            break
        case .right:
            animationNode = SKSpriteNode(imageNamed: "rightHitEffect")
            break
        }
        
        
        
        animationNode.zPosition = -1000
        animationNode.alpha = 0.0
        animationNode.position.x = circle.position.x
        animationNode.position.y = circle.position.y
        circle.addChild(animationNode)
        
        
        rotation.timingFunction = { t in
            return t*t*t
        }
        scaleUp.timingFunction = { t in
            return t*t*t
        }
        scaleDown.timingFunction = { t in
            return t*t*t
        }
        
    }
    
    func runHitAnimation() {
        if animationNode.hasActions() {
            animationNode.run(SKAction.group([SKAction.scale(by: 1.1, duration: 0.2), SKAction.rotate(byAngle: 360, duration: 0.3)]))
        } else {
            animationNode.run(SKAction.sequence([fadeInAndScaleUp, hapticAction, scaleDownAndFadeOut]))
        }
    }
    
}

//MARK: - Active Circle Animation
extension FaceExpressionNode {
    
    func checkIfCircleIsActive(with status: Bool) {
        
        haptic.setupImpactHaptic(style: .light)
        
        switch positions {
        case .left:
            if status == true {
                circle.run(SKAction.setTexture(SKTexture(imageNamed: leftFaceIndicator.activeTexture)))
            } else {
                circle.run(SKAction.setTexture(SKTexture(imageNamed: leftFaceIndicator.defaultTexture)))
            }
        case .middle:
            if status == true {
                circle.run(SKAction.setTexture(SKTexture(imageNamed: middleFaceIndicator.activeTexture)))
            } else {
                circle.run(SKAction.setTexture(SKTexture(imageNamed: middleFaceIndicator.defaultTexture)))
            }
        case .right:
            if status == true {
                circle.run(SKAction.setTexture(SKTexture(imageNamed: rightFaceIndicator.activeTexture)))
            } else {
                circle.run(SKAction.setTexture(SKTexture(imageNamed: rightFaceIndicator.defaultTexture)))
            }
        }
        
        
        
    }
    
}
