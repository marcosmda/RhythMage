//
//  HitLineNode.swift
//  RhythMage
//
//  Created by Marcos Vinicius Majeveski De Angeli on 19/10/21.
//

import Foundation
import SpriteKit

class HitColorModel: SKShapeNode{
    var color: HitColors
    
    let startPoint = CGPoint(x: 0.6, y: 1)
    let endPoint = CGPoint(x: 0.6, y: 0)
    
    
    func setTexture(){
        var uiColor = UIColor()
        
        switch color {
        case .successuful:
            uiColor = .primary
        case .failure:
            uiColor = .red
        }
        let image = UIImage.gradientImage(withBounds: self.frame, startPoint: startPoint, endPoint: endPoint, colors: [uiColor.cgColor, UIColor.clear.cgColor])
        
        let gradientTexture = SKTexture(image: image)
        self.fillTexture = gradientTexture
        self.strokeColor = .clear
        
    }
    //MARK: - Initialization
    init(color: HitColors) {
        self.color = color
        super.init()
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

enum HitColors{
    case successuful
    case failure
}

class HitLineNode: SKNode {
    let height: CGFloat
    let color: UIColor
    
    let width = UIScreen.main.bounds.width
    
    let startPoint = CGPoint(x: 0.6, y: 1)
    let endPoint = CGPoint(x: 0.6, y: 0)
    var lineNode: SKShapeNode?
    var imageB: UIImage?
    var imageR: UIImage?
    
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
        imageB = UIImage.gradientImage(withBounds: lineNode.frame, startPoint: startPoint, endPoint: endPoint, colors: [UIColor.primary.cgColor, UIColor.clear.cgColor])
        imageR = UIImage.gradientImage(withBounds: lineNode.frame, startPoint: startPoint, endPoint: endPoint, colors: [UIColor.red.cgColor, UIColor.clear.cgColor])

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
    
    public func handleFillColors(with hitColors: HitColors){
        guard let lineNode = lineNode , let imageB = imageB , let imageR = imageR else {
            return
        }
        switch hitColors {
        case .successuful:
            
            let gradientTexture = SKTexture(image: imageB)
            
            lineNode.fillTexture = gradientTexture
            lineNode.fillColor = .primary
            
            //Timer.scheduledTimer(timeInterval: 0.3, target: self, selector: #selector(setHitLineToClear), userInfo: nil, repeats: false)
            
        case .failure:
            let gradientTexture = SKTexture(image: imageR)
            
            lineNode.fillTexture = gradientTexture
            lineNode.fillColor = .red
            Timer.scheduledTimer(timeInterval: 0.3, target: self, selector: #selector(setHitLineToClear), userInfo: nil, repeats: false)
            lineNode.strokeColor = .clear
        }
    }
    
   @objc func setHitLineToClear(){
       guard let lineNode = lineNode , let imageB = imageB else {
           return
       }
        if lineNode.fillColor != .primary {
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


