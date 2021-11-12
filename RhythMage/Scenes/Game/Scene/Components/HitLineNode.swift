//
//  HitLineNode.swift
//  RhythMage
//
//  Created by Marcos Vinicius Majeveski De Angeli on 19/10/21.
//

import Foundation
import SpriteKit

class HitLineNode: SKNode {
    let height: CGFloat
    let color: UIColor
    
    let width = UIScreen.main.bounds.width
    
    let startPoint = CGPoint(x: 0.6, y: 1)
    let endPoint = CGPoint(x: 0.6, y: 0)
    var lineNode: SKShapeNode?
    var redImage: UIImage?
    var blueImage: UIImage?
    
    //MARK: - Initialization
    init(height: CGFloat, color: UIColor = .white) {
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
    }
    
    private func addShape() {
        let rectSize = CGSize(width: width, height: height)
        let origin = CGPoint(x: UIScreen.main.bounds.minX, y: UIScreen.main.bounds.minY)
        let rect = CGRect(origin: origin, size: rectSize)
        //lineNode = HitColorModel(color: .successuful)
        lineNode = SKShapeNode(rect: rect)//HitColorModel(color: .successuful)//
        guard let lineNode = lineNode else {
            return
        }
        redImage = UIImage.gradientImage(withBounds: lineNode.frame, startPoint: startPoint, endPoint: endPoint, colors: [UIColor.red.cgColor, UIColor.clear.cgColor])
        blueImage = UIImage.gradientImage(withBounds: lineNode.frame, startPoint: startPoint, endPoint: endPoint, colors: [UIColor.primary.cgColor, UIColor.clear.cgColor])
        setHitLineToBlue()
        //lineNode.fillColor = .primary
        //lineNode.strokeColor = .clear
        self.addChild(lineNode)
    }
    
    private func addBody() {
        let size = CGSize(width: width, height: height)
        let body = SKPhysicsBody(rectangleOf: size, center: self.position)
        body.isDynamic = false
        body.usesPreciseCollisionDetection = true
        body.categoryBitMask = GameSceneCattegoryTypes.hitLine.rawValue
        body.contactTestBitMask = 0
        body.collisionBitMask = 0
        
        self.physicsBody = body
    }
    
    public func hitLineErrorColor(){
        guard let lineNode = lineNode, let redImage = redImage else {
            return
        }
        
        lineNode.fillTexture = SKTexture(image: redImage)
        lineNode.fillColor = .red
        Timer.scheduledTimer(timeInterval: 0.2, target: self, selector: #selector(setHitLineToBlue), userInfo: nil, repeats: false)
        lineNode.strokeColor = .clear
        
    }
    
    @objc func setHitLineToBlue(){
        guard let lineNode = lineNode , let blueImage = blueImage else {
            return
        }
        if lineNode.fillColor != .primary {
            lineNode.fillTexture = SKTexture(image: blueImage)
            lineNode.fillColor = .primary
            lineNode.strokeColor = .clear
        }
    }
}

extension UIImage {
    static func gradientImage(withBounds: CGRect, startPoint: CGPoint, endPoint: CGPoint, colors: [CGColor]) -> UIImage {
        
        // Configure the gradient layer based on input
        let gradientLayer = CAGradientLayer()
        gradientLayer.frame = withBounds
        gradientLayer.colors = colors
        gradientLayer.startPoint = startPoint
        gradientLayer.endPoint = endPoint
        // Render the image using the gradient layer
        UIGraphicsBeginImageContext(gradientLayer.bounds.size)
        gradientLayer.render(in: UIGraphicsGetCurrentContext()!)
        let image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        return image!
    }
}


