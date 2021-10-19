//
//  MainOrbNode.swift
//  RhythMage
//
//  Created by Marcos Vinicius Majeveski De Angeli on 19/10/21.
//

import SpriteKit

class MainOrbNode: SKNode {
    let size: CGFloat
    let color: UIColor
    
    var rectCornerRadius: CGFloat {
        return self.size/CGFloat(4.9)
    }
    
    //MARK: - Initialization
    init(size: CGFloat, color: UIColor) {
        self.size = size
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
    }
    
    func addShape() {
        let rectSize = CGSize(width: size, height: size)
        let origin = CGPoint(x: -size/2, y: -size/2)
        let rect = CGRect(origin: origin, size: rectSize)
        let frontNode = SKShapeNode(rect: rect, cornerRadius: rectCornerRadius)
        let middleNode = SKShapeNode(rect: rect, cornerRadius: rectCornerRadius)
        let backNode = SKShapeNode(rect: rect, cornerRadius: rectCornerRadius)
        
        let nodes = [frontNode, middleNode, backNode]
        for node in nodes {
            node.fillColor = color
            node.strokeColor = .clear
            node.glowWidth = 10
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
        let body = SKPhysicsBody(circleOfRadius: size/2)
        body.isDynamic = false
        
        self.physicsBody = body
    }
}
