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
        self.backgroundColor = .label
    }
    
    func addChildren() {
        self.addChild(mainOrb)
        self.addChild(hitLine)
    }
    
    func setupPositions() {
        mainOrb.position = CGPoint(x: screenCenter.x, y: GameScene.orbYPosition)
        mainOrb.zPosition = 999999
        hitLine.position = CGPoint(x: screenCenter.x, y: GameScene.orbYPosition + mainOrb.radius + 3)
        hitLine.isHidden = true //Remove is hitLine should be visible
    }
    
}
