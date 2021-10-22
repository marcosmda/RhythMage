//
//  CircularGradientView.swift
//  RhythMage
//
//  Created by Lucas Frazão on 19/10/21.
//

import UIKit

class CircularGradientView: UIView {
    
    let path = UIBezierPath()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = .white
     
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        
        // Drawing code
        let radius: Double = 100
        
        let center = CGPoint(x: rect.width / 2, y: rect.height / 2)
        path.move(to: CGPoint(x: center.x, y: center.y))
        
        for i in stride(from: 0, through: 361.0, by: 1) {
            
            let radians = i * Double.pi / 180
            
            let x = Double(center.x) + radius * cos(radians)
            let y = Double(center.y) + radius * sin(radians)
            
            path.addLine(to: CGPoint(x: x, y: y))
            
        }
        
        //UIColor.primary.setFill()
        //path.fill()
        
    }
    
    func drawCircleInsideView(view: UIView, count: Int){
        let halfSize:CGFloat = min(view.bounds.size.width/2, view.bounds.size.height/2) / CGFloat(count)
        var i = 0
        var lastPosition = 0
        while i <= count {
            let circlePath = UIBezierPath(
                arcCenter: CGPoint(x:halfSize,y:halfSize + (CGFloat(i) * halfSize*2)),
                radius: CGFloat(100),
                startAngle: CGFloat(0),
                endAngle:CGFloat(Double.pi * 2),
                clockwise: true)
            let shapeLayer = CAShapeLayer()
            shapeLayer.path = circlePath.cgPath
            shapeLayer.fillColor = UIColor.primary.cgColor
            view.layer.addSublayer(shapeLayer)
            lastPosition = lastPosition + 2
            i += 1
        }
    }
    

}
