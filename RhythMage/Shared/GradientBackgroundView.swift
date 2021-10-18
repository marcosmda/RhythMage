//
//  GradientBackgroundView.swift
//  RhythMage
//
//  Created by Lucas Frazão on 18/10/21.
//

import UIKit

class GradientBackgroundView: UIView {

    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func setupGradient(with view: UIView) {
        let gradientLayer = CAGradientLayer()
        gradientLayer.colors = [UIColor.primary.cgColor, UIColor.label.cgColor]
        gradientLayer.locations = [0.0, 1.0]
        gradientLayer.frame = view.bounds
        
        self.layer.insertSublayer(gradientLayer, at:0)
    }
    
    
}
