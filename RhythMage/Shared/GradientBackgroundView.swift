//
//  GradientBackgroundView.swift
//  RhythMage
//
//  Created by Lucas Frazão on 18/10/21.
//

import UIKit

class GradientBackgroundView: UIView {

    var timer: Timer?
    
    private var currentGradient: Int = 0
    
    let gradientLayer = CAGradientLayer()
    var gradientSet = [[CGColor]]()
    
    let gradientOne = UIColor.primary.cgColor
    let gradientTwo = UIColor.label.cgColor
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        gradientSet.append([gradientOne, gradientTwo])
        gradientSet.append([gradientTwo, gradientOne])
     
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
        
            self.layer.insertSublayer(gradientLayer, at:0)
        
            animationBackground()
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
    
    
}

extension GradientBackgroundView: CAAnimationDelegate {
    
    func animationDidStop(_ anim: CAAnimation, finished flag: Bool) {
            if flag {
                gradientLayer.colors = gradientSet[currentGradient]
                animationBackground()
            }
        }
    
}
