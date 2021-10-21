//
//  SKShapeNode.swift
//  RhythMage
//
//  Created by Marcos Vinicius Majeveski De Angeli on 19/10/21.
//

import Foundation
import SpriteKit

extension SKShapeNode {
    
    public func rotate(angle: Double) {
        var transform = CGAffineTransform(rotationAngle: CGFloat(angle*2*3.1415/360))
        self.path = self.path?.mutableCopy(using: &transform)
    }
}
