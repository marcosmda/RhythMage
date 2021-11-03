//
//  GameScene+GameViewController.swift
//  RhythMage
//
//  Created by Bruna Costa on 29/10/21.
//

import Foundation
import SpriteKit

extension GameScene {
    
    public func addTileOrb(tile tileInteraction: TileInteraction, scrollVelocity: Double, startDelayTime: Double) {
        let duration = tileInteraction.endTime - tileInteraction.startTime
        var height: Double = 0
        if duration > 0.4 {
            height = duration * scrollVelocity
        } else {
            height = 0
        }
        
        let tile = TileOrbNode(tileInteraction: tileInteraction, height: height)
        tile.position.y = GameScene.hitPoint + scrollVelocity * (tileInteraction.startTime + startDelayTime)
        
        let width = UIScreen.main.bounds.width
        switch tileInteraction.xPosition {
        case ScreenScrollArea.left.rawValue:
            tile.position.x = width/6
        case ScreenScrollArea.middle.rawValue:
            tile.position.x = 3*width/6
        case ScreenScrollArea.right.rawValue:
            tile.position.x = 5*width/6
        default:
            tile.position.x = width/2
        }
        
        tileOrbs.append(tile)
        hashes.append(tile.physicsBody!.hash)
        self.addChild(tile)
    }
    
    public func setVelocity(velocity: Float) {
        let velocity = CGFloat(-velocity)
        for tile in tileOrbs {
            tile.physicsBody?.velocity = CGVector(dx: 0, dy: velocity)
        }

    }
    
}
