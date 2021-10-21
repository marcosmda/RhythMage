//
//  SKNode.swift
//  RhythMage
//
//  Created by Marcos Vinicius Majeveski De Angeli on 19/10/21.
//

import Foundation
import SpriteKit

extension SKNode {
    func showCenter(with size: CGFloat = 3) {
        let circle = SKShapeNode(circleOfRadius: size)
        circle.fillColor = .red
        self.addChild(circle)
        circle.position = self.position
    }
}
