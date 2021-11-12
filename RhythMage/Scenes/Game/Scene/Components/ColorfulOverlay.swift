//
//  ColorfulOverlay.swift
//  RhythMage
//
//  Created by Bruna Costa on 11/11/21.
//

import SpriteKit

class ColorfulOverlay: SKNode{
    
    let height: CGFloat
    let color: UIColor
    let width = UIScreen.main.bounds.width
    
    
    //MARK: - Initialization
    init(height: CGFloat, color: UIColor) {
        self.height = height
        self.color = .blue
        
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
        let rectSize = CGSize(width: width, height: height)
        let origin = CGPoint(x: -width/2, y: -height/2)
        let rect = CGRect(origin: origin, size: rectSize)
        let lineNode = SKShapeNode(rect: rect)
        
        lineNode.fillColor = color
        lineNode.strokeColor = .black
        
        self.addChild(lineNode)
    }
    
    func addBody() {
        let size = CGSize(width: width, height: 50)
        let body = SKPhysicsBody(rectangleOf: size, center: self.position)
        body.isDynamic = false
        body.usesPreciseCollisionDetection = true
        body.categoryBitMask = GameSceneCattegoryTypes.hitLine.rawValue
        body.contactTestBitMask = 0
        body.collisionBitMask = 0
        
        self.physicsBody = body
    }
    
}
