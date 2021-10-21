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
    
    let gradientOne = UIColor.backgroundColor.cgColor
    let gradientTwo = UIColor.backgroundColor2.cgColor
    let gradientThree = UIColor.backgroundColor3.cgColor
    let gradientFour = UIColor.backgroundColor4.cgColor
    let gradientFive = UIColor.backgroundColor5.cgColor
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        gradientSet.append([gradientOne, gradientTwo, gradientThree, gradientFour, gradientFive])
        gradientSet.append([gradientFive, gradientFour, gradientThree, gradientTwo, gradientOne])
        self.backgroundColor = .primary
        self.clipsToBounds = true
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupCircleBackgroundBlur() {
        drawCircles()
        drawBlurBackground()
    }

    func setupGradient(with view: UIView) {
        gradientLayer.colors = gradientSet[0]
        gradientLayer.locations = [0.0, 0.25, 0.5, 0.75, 1.0]
        gradientLayer.frame = view.bounds
        gradientLayer.drawsAsynchronously = true
        gradientLayer.startPoint = CGPoint(x:1, y:0)
        gradientLayer.endPoint = CGPoint(x:0, y:1)
        self.layer.insertSublayer(gradientLayer, at:0)
        
        animationBackground()
    }
    
    @objc func animationBackground() {
        
        if currentGradient < gradientSet.count - 1 {
            currentGradient += 1
        } else {
            currentGradient = 0
        }
        
//        DispatchQueue.main.async { [weak self] in
//            guard let self = self else {return}
            let gradientChangeAnimation = CABasicAnimation(keyPath: "colors")
            gradientChangeAnimation.delegate = self
            gradientChangeAnimation.duration = 5.0
            gradientChangeAnimation.toValue = self.gradientSet[self.currentGradient]
            gradientChangeAnimation.fillMode = CAMediaTimingFillMode.forwards
            gradientChangeAnimation.isRemovedOnCompletion = false
            self.gradientLayer.add(gradientChangeAnimation, forKey: "colorChange")
  //      }
        
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
            
            //MARK: - popLast() Function
            shapeLayer.fillColor = auxColors.popLast()?.cgColor
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
           
            let anims: CAAnimationGroup = CAAnimationGroup()
            anims.animations = [pathAnim]
            anims.isRemovedOnCompletion = false
            anims.duration = CFTimeInterval(Float.random(in: 9.0...14.0))
            anims.timingFunction = CAMediaTimingFunction(name: .easeInEaseOut)
            anims.autoreverses = true
            anims.repeatCount = MAXFLOAT
            anims.fillMode = CAMediaTimingFillMode.forwards;

            shapeLayer.add(anims, forKey: nil);
        
            
        }
        
    }
    
    func drawBlurBackground() {
        let blurEffect = UIBlurEffect(style: .systemChromeMaterialDark)
        let blurEffectView = UIVisualEffectView(effect: blurEffect)
        blurEffectView.frame = self.bounds
        blurEffectView.alpha = 0.98
        blurEffectView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        self.addSubview(blurEffectView)
    }
    
}

extension GradientBackgroundView: CAAnimationDelegate {
    
    func animationDidStop(_ anim: CAAnimation, finished flag: Bool) {
            if flag {
                gradientLayer.colors = gradientSet[currentGradient]
                animationBackground()
            }
        }
    
}
