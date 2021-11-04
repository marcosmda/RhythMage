//
//  TileOrbNode.swift
//  RhythMage
//
//  Created by Marcos Vinicius Majeveski De Angeli on 19/10/21.
//

import SpriteKit

class TileOrbNode: SKNode {
    var colors: [UIColor] = [.pinkOrb, .blueOrb, .greenOrb, .orangeOrb, .yellowOrb]
    let defaultHeight: CGFloat = 50
    
    let tileInteraction: TileInteraction
    let hasTail: Bool
    let height: CGFloat
    var color: UIColor {
        return setColor()
    }
    
    var rectCornerRadius: CGFloat {
        return self.defaultHeight/CGFloat(4)
    }
    
    
    //MARK: - Animations
    
    let rotation = SKAction.rotate(toAngle: 270, duration: 0.3)
    let fadeOut = SKAction.fadeOut(withDuration: 0.3)
    let scaleDown = SKAction.scale(to: CGSize(width: 5, height: 5), duration: 0.3)
    var move = SKAction()
    lazy var scaleDownAndFadeOut = SKAction.group([rotation, move, scaleDown, fadeOut])
    
    //MARK: - Initialization
    init(tileInteraction: TileInteraction, height: CGFloat) {
        self.tileInteraction = tileInteraction

        //No tail tile
        self.hasTail = false
        self.height = defaultHeight
        
        //Tail tile
//        self.hasTail = height > defaultHeight/2 ? true : false
//        self.height = height > defaultHeight/2 ? height : defaultHeight/2
        
        super.init()
        setupNode()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - Methods
    func setupNode() {
        addShape()
        addBody()
        if hasTail {
            addKiteTail()
        }
        
        var orb = SKSpriteNode()
        
        switch color {
        case .yellowOrb:
            orb = SKSpriteNode(imageNamed: "yellowOrb")
            break
        case .orangeOrb:
            orb = SKSpriteNode(imageNamed: "orangeOrb")
            break
        case .greenOrb:
            orb = SKSpriteNode(imageNamed: "greenOrb")
            break
        case .blueOrb:
            orb = SKSpriteNode(imageNamed: "blueOrb")
            break
        case .pinkOrb:
            orb = SKSpriteNode(imageNamed: "pinkOrb")
            break
        default:
            break
        }
        
        self.addChild(orb)
    }
    
    func addShape() {
        let rectSize = CGSize(width: defaultHeight, height: defaultHeight)
        let origin = CGPoint(x: -defaultHeight/2, y: -defaultHeight/2)
        let rect = CGRect(origin: origin, size: rectSize)
        let frontNode = SKShapeNode(rect: rect, cornerRadius: rectCornerRadius)
        let middleNode = SKShapeNode(rect: rect, cornerRadius: rectCornerRadius)
        let backNode = SKShapeNode(rect: rect, cornerRadius: rectCornerRadius)
        
        let nodes = [frontNode, middleNode, backNode]
        for node in nodes {
            node.fillColor = color
            node.strokeColor = .clear
        }
        
        middleNode.alpha = 0.75
        backNode.alpha = 0.5
        
        middleNode.rotate(angle: 30)
        backNode.rotate(angle: 45)
        
        self.addChild(backNode)
        self.addChild(middleNode)
        self.addChild(frontNode)
    }
    
    func addBody() {
        let size = CGSize(width: defaultHeight, height: height)
        let position = CGPoint(x: self.position.x, y: self.position.y + height/2)
        let body = SKPhysicsBody(rectangleOf: size, center: position)
        //body.isDynamic = false
        body.usesPreciseCollisionDetection = true
        body.affectedByGravity = false
        body.restitution = 0
        body.friction = 0
        body.linearDamping = 0
        
        body.categoryBitMask = GameSceneCattegoryTypes.tileOrb.rawValue
        body.contactTestBitMask = GameSceneCattegoryTypes.mainOrb.rawValue
        body.collisionBitMask = 0
        
        self.physicsBody = body
    }
    
    func addKiteTail() {
        let rectSize = CGSize(width: defaultHeight, height: height)
        let origin = CGPoint(x: -defaultHeight/2, y: 0)
        let rect = CGRect(origin: origin, size: rectSize)
        let kiteTail = SKShapeNode(rect: rect, cornerRadius: rectCornerRadius)
        
        kiteTail.alpha = 0.4
        kiteTail.strokeColor = color
        kiteTail.fillColor = color
        
        self.addChild(kiteTail)
    }
    
    func setColor() -> UIColor{
        //Random color
//        if colors.count > 1 {
//            let index = Int.random(in: 0..<colors.count)
//            let color = colors[index]
//            colors.removeAll()
//            colors.append(color)
//            return color
//        } else {return colors[0]}
        
        //Color by position
        switch tileInteraction.xPosition {
        case 0:
            return .blueOrb
        case 1:
            return .greenOrb
        case 2:
            return .yellowOrb
        default:
            return .pinkOrb
        }
    }
    
    func setAnimations(screenCenter: CGFloat, mainOrbRadius: CGFloat) {
        var point = CGPoint()
        switch tileInteraction.xPosition {
        case 0:
            point = CGPoint(x: screenCenter - 135, y: GameScene.orbYPosition + mainOrbRadius)
        case 1:
            point = CGPoint(x: screenCenter, y: GameScene.orbYPosition + mainOrbRadius)
        case 2:
            point = CGPoint(x: screenCenter + 135, y: GameScene.orbYPosition + mainOrbRadius)
        default:
            return
        }
        move = SKAction.move(to: point, duration: 0.3)
        
        scaleDown.timingFunction = { t in
            return t*t*t*t*t
        }
        rotation.timingFunction = { t in
            return t*t*t*t*t
        }
        move.timingFunction = { t in
            return t*t*t*t*t
            
        }
    }
    
    func runHitAnimation() {
        if self.hasActions() {
            self.removeAllActions()
        }
        self.run(scaleDownAndFadeOut){
            self.removeFromParent()
        }
    }
}
