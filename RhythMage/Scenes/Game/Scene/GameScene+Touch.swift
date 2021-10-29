//
//  GameScene+Touch.swift
//  RhythMage
//
//  Created by Bruna Costa on 29/10/21.
//

import Foundation
import SpriteKit

extension GameScene {
    
    /// This archive is about the movements and touches on the game
    /// - Parameters:
    ///   - touches: type of movements
    ///   - event: event description

    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        guard let touch = touches.first else {return}
        let location = touch.location(in: self)
        let touchedNodes = self.nodes(at: location)
        
        for node in touchedNodes.reversed() {
            if node.name == GameSceneNodeNames.mainOrb.rawValue {
                self.currentNode = mainOrb
            }
        }
    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        guard let touch = touches.first else {return}
        let node = self.currentNode
        let location = touch.location(in: self)
        
        node?.position.x = location.x
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.currentNode = nil
    }
    override func touchesCancelled(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.currentNode = nil
    }
    
}
