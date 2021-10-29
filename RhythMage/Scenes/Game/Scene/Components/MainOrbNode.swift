//
//  MainOrbNode.swift
//  RhythMage
//
//  Created by Marcos Vinicius Majeveski De Angeli on 19/10/21.
//

import SpriteKit

class MainOrbNode: SKNode {
    static let heightToRadiusCte: CGFloat = 1.25
    let height: CGFloat
    let color: UIColor
    
    var rectCornerRadius: CGFloat {
        return self.height/CGFloat(4)
    }
    var radius: CGFloat {
        return (height * MainOrbNode.heightToRadiusCte)/2
    }
    
    //MARK: - Initialization
    init(height: CGFloat, color: UIColor) {
        self.height = height
        self.color = color
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
        self.name = GameSceneNodeNames.mainOrb.rawValue
    }
    
    func addShape() {
        let rectSize = CGSize(width: height, height: height)
        let origin = CGPoint(x: -height/2, y: -height/2)
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
        
        frontNode.rotate(angle: 45)
        middleNode.rotate(angle: 75)
        backNode.rotate(angle: 90)
        
        self.addChild(backNode)
        self.addChild(middleNode)
        self.addChild(frontNode)
    }
    
    func addBody() {
        let size = CGSize(width: radius*2, height: radius*2)
        let body = SKPhysicsBody(rectangleOf: size, center: self.position)
        body.isDynamic = false
        body.usesPreciseCollisionDetection = true
        body.categoryBitMask = GameSceneCattegoryTypes.mainOrb.rawValue
        body.contactTestBitMask = GameSceneCattegoryTypes.tileOrb.rawValue
        body.collisionBitMask = 0
        
        
        self.physicsBody = body
    }
}
