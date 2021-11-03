//
//  GameScene+ContactDelegate.swift
//  RhythMage
//
//  Created by Bruna Costa on 29/10/21.
//
import SpriteKit

extension GameScene: SKPhysicsContactDelegate {
    
    func initContactDelegate(){
        physicsWorld.contactDelegate = self
    }
    
    func didBegin(_ contact: SKPhysicsContact) {
        //guard let delegate = gameDelegate else {return}
        let tileBody = contact.bodyA.categoryBitMask == GameSceneCattegoryTypes.tileOrb.rawValue ? contact.bodyA : contact.bodyB
        
//        if hashes.contains(tileBody.hash){
//            let tile = tileBody.node as! TileOrbNode
//
//            if tile.hasTail {
//                if let time = delegate.getElapsedTime() {
//                    tileKiteContactStartTime = time
//                }
//            } else {
//                score += tile.tileInteraction.minimumScore
//                hashes = hashes.filter{$0 != tileBody.hash}
//            }
//        }
        guard let tileNode = tileBody.node  as? TileOrbNode else {return}
        tilesInContact[tileNode.hash] = tileNode
        
    }
    
    func didEnd(_ contact: SKPhysicsContact) {
//        guard let delegate = gameDelegate else {return}
        let tileBody = contact.bodyA.categoryBitMask == GameSceneCattegoryTypes.tileOrb.rawValue ? contact.bodyA : contact.bodyB
        
        //Only the tiles with kite Tail enters this if
//        if hashes.contains(tileBody.hash){
//            let tile = tileBody.node as! TileOrbNode
//            guard let actualTime = delegate.getElapsedTime() else {
//                tileKiteContactStartTime = 0
//                return
//            }
//
//            score += 2 * tile.tileInteraction.minimumScore * (actualTime - tileKiteContactStartTime)
//            tileKiteContactStartTime = 0
//        }
        
        guard let tileNode = tileBody.node as? TileOrbNode else {return}
        if tilesInContact.keys.contains(tileNode.hash) {
            tilesInContact.removeValue(forKey: tileNode.hash)
        }
    }
}
