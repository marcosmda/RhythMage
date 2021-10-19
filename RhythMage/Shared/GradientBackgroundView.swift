//
//  GradientBackgroundView.swift
//  RhythMage
//
//  Created by Lucas Frazão on 18/10/21.
//

import UIKit
import SwiftUI

class GradientBackgroundView: UIView {

    var timer: Timer?
    
    private var currentGradient: Int = 0
    
    var circularGradientView = CircularGradientView()
    
    let gradientLayer = CAGradientLayer()
    var gradientSet = [[CGColor]]()
    
    let gradientOne = UIColor.primary.cgColor
    let gradientTwo = UIColor.label.cgColor
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        gradientSet.append([gradientOne, gradientTwo])
        gradientSet.append([gradientTwo, gradientOne])
        self.backgroundColor = .primary
    
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func setupGradient(with view: UIView) {

            gradientLayer.colors = gradientSet[0]
            gradientLayer.locations = [0.35, 0.85]
            gradientLayer.frame = view.bounds
            gradientLayer.startPoint = CGPoint(x:1, y:0)
            gradientLayer.endPoint = CGPoint(x:0, y:1)
            gradientLayer.drawsAsynchronously = true
        
            //self.layer.insertSublayer(gradientLayer, at:0)
        
            animationBackground()
        
            drawCircles()
        
    }
    
    @objc func animationBackground() {

        if currentGradient < gradientSet.count - 1 {
            currentGradient += 1
        } else {
            currentGradient = 0
        }
        
        DispatchQueue.main.async {
            let gradientChangeAnimation = CABasicAnimation(keyPath: "colors")
            gradientChangeAnimation.delegate = self
            gradientChangeAnimation.duration = 7.0
            gradientChangeAnimation.toValue = self.gradientSet[self.currentGradient]
            gradientChangeAnimation.fillMode = CAMediaTimingFillMode.forwards
            gradientChangeAnimation.isRemovedOnCompletion = false
            self.gradientLayer.add(gradientChangeAnimation, forKey: "colorChange")
        }
        
    }
    
    func drawCircles() {
    
        var x = 50
        var y = 100
        
        var i = 0
        
        let colors: [UIColor] = [UIColor.backgroundColor, UIColor.backgroundColor2, UIColor.backgroundColor3, UIColor.backgroundColor4, UIColor.backgroundColor5]
        
        var auxColors: [UIColor] = []
        
        while i <= 9 {
            
            if auxColors == [] {
                auxColors = colors
            }
            
            i += 1
            let circlePath = UIBezierPath(
                arcCenter: CGPoint(x:x,y:y),
                radius: 150,
                startAngle: CGFloat(0),
                endAngle:CGFloat(Double.pi * 2),
                clockwise: true)
            let shapeLayer = CAShapeLayer()
            shapeLayer.path = circlePath.cgPath
            let index = Int.random(in: 0..<auxColors.count)
            shapeLayer.fillColor = auxColors[index].cgColor
            auxColors.remove(at: index)
            self.layer.addSublayer(shapeLayer)
            
                if i % 2 != 0 {
                    x = 335
                } else {
                    x = 50
                }
                
                if i > 1 {
                    y += 120
                }
            
            let xDirection = Float.random(in: Float(circlePath.bounds.midX/2)...Float(circlePath.bounds.midX))
            let yDirection = Float.random(in: Float(circlePath.bounds.midY/2)...Float(circlePath.bounds.midY))
            
            let newPath: UIBezierPath = UIBezierPath(arcCenter: CGPoint(x: CGFloat(xDirection), y: CGFloat(yDirection)), radius: 200, startAngle: CGFloat(0), endAngle:CGFloat(Double.pi * 2), clockwise: true);

            let pathAnim : CABasicAnimation = CABasicAnimation(keyPath: "path");
            pathAnim.toValue = newPath.cgPath;

            let anims: CAAnimationGroup = CAAnimationGroup();
            anims.animations = [pathAnim];
            anims.isRemovedOnCompletion = false;
            anims.duration = CFTimeInterval(Float.random(in: 9.0...14.0))
            anims.timingFunction = CAMediaTimingFunction(name: .easeInEaseOut)
            anims.autoreverses = true
            anims.repeatCount = MAXFLOAT
            anims.fillMode = CAMediaTimingFillMode.forwards;

            shapeLayer.add(anims, forKey: nil);
            
        }
     
        let blurEffect = UIBlurEffect(style: .systemChromeMaterialDark)
        let blurEffectView = UIVisualEffectView(effect: blurEffect)
        blurEffectView.frame = self.bounds
        blurEffectView.alpha = 0.98
        
        blurEffectView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        self.addSubview(blurEffectView)
        
    }
    
    func scaleShape(shape : CAShapeLayer){

        let newRadius : CGFloat = 120;

        let newPath: UIBezierPath = UIBezierPath(arcCenter: CGPoint(x: shape.frame.midX, y: shape.frame.midY), radius: newRadius, startAngle: CGFloat(0),endAngle:CGFloat(Double.pi * 2), clockwise: true);


        let newBounds : CGRect = CGRect(x: 0, y: 0, width: 2 * newRadius, height: 2 * newRadius)
        let pathAnim : CABasicAnimation = CABasicAnimation(keyPath: "path");

        pathAnim.toValue = newPath.cgPath;

        let boundsAnim : CABasicAnimation = CABasicAnimation(keyPath: "bounds");
        boundsAnim.toValue = newBounds

        let anims: CAAnimationGroup = CAAnimationGroup();
        anims.animations = [pathAnim, boundsAnim];
        anims.isRemovedOnCompletion = false;
        anims.duration = 2.0;
        anims.fillMode = CAMediaTimingFillMode.forwards;

        shape.add(anims, forKey: nil);
    }
    
}

extension GradientBackgroundView: CAAnimationDelegate {
    
    func animationDidStop(_ anim: CAAnimation, finished flag: Bool) {
            if flag {
                gradientLayer.colors = gradientSet[currentGradient]
                animationBackground()
                drawCircles()
            }
        }
    
}
