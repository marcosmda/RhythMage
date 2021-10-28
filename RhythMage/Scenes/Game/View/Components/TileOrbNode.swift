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
    
    //MARK: - Initialization
    init(tileInteraction: TileInteraction, height: CGFloat) {
        self.tileInteraction = tileInteraction
        self.hasTail = height > defaultHeight/2 ? true : false
        self.height = height > defaultHeight/2 ? height : defaultHeight/2
        super.init()
        setupNode()
//        self.showCenter()
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
        if colors.count > 1 {
            let index = Int.random(in: 0..<colors.count)
            let color = colors[index]
            colors.removeAll()
            colors.append(color)
            return color
        } else {return colors[0]}
    }
}
