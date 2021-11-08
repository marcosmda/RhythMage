//
//  GameScene+PrepareScene.swift
//  RhythMage
//
//  Created by Bruna Costa on 29/10/21.
//

import Foundation
import SpriteKit

extension GameScene {
    
    func setupScene() {
        addChildren()
        setupPositions()
        self.backgroundColor = .clear
    }
    
    func addChildren() {
        self.addChild(hitLine)

        for facialExpression in facialExpressions {
            self.addChild(facialExpression)
        }
        
        
    }
    
    func setupPositions() {
        facialExpressions[0].position = CGPoint(x: screenCenter.x - screenCenter.x/1.5, y: GameScene.orbYPosition + mainOrb.radius + 3)
        facialExpressions[1].position = CGPoint(x: screenCenter.x, y: GameScene.orbYPosition + mainOrb.radius + 3)
        facialExpressions[2].position = CGPoint(x: screenCenter.x + screenCenter.x/1.5, y: GameScene.orbYPosition + mainOrb.radius + 3)
        
        hitLine.isHidden = true //Remove is hitLine should be visible
        
    }
    
}
