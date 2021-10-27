//
//  GameScene.swift
//  RhythMage
//
//  Created by Marcos Vinicius Majeveski De Angeli on 01/10/21.
//

import SpriteKit
import GameplayKit

enum GameSceneNodeNames: String {
    case mainOrb
    case pauseButton
}

enum GameSceneCattegoryTypes: UInt32 {
    case mainOrb = 0x1
    case hitLine = 0x2
    case tileOrb = 0x3
}

protocol GameSceneDelegate {
    func getElapsedTime() -> Double
    func pauseGame()
    func updatedScore(score: Double)
}

class GameScene: SKScene {
    //MARK: - Properties
    static let mainOrbHeight: CGFloat = 88
    static let orbYPosition: CGFloat = 80
    static var hitPoint: CGFloat {
        return orbYPosition + MainOrbNode.heightToRadiusCte*mainOrbHeight/2 + 3
    }
    
    let mainOrb = MainOrbNode(height: GameScene.mainOrbHeight, color: .pinkOrb)
    let hitLine = HitLineNode(height: 3)
    let screenCenter = CGPoint(x: UIScreen.main.bounds.width/2, y: UIScreen.main.bounds.height/2)
    
    var tileOrbs = [TileOrbNode]()
    var hashes = [Int]()
    var score: Double = 0 {
        didSet {
            gameDelegate?.updatedScore(score: score.rounded())
        }
    }
    var gameDelegate: GameSceneDelegate?
    
    private var currentNode: SKNode?
    private var tileKiteContactStartTime: Double = 0
    
    //MARK: - Initialization
    override init(size: CGSize) {
        super.init(size: size)
        
        physicsWorld.contactDelegate = self
        
        setupScene()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - Public Methods
    func addTileOrb(tile tileInteraction: TileInteraction, scrollVelocity: Double, startDelayTime: Double) {
        let duration = tileInteraction.endTime - tileInteraction.startTime
        var height: Double = 0
        if duration > 0.4 {
            height = duration * scrollVelocity
        } else {
            height = 0
        }
        
        let tile = TileOrbNode(tileInteraction: tileInteraction, height: height)
        tile.position.y = 130 + GameScene.hitPoint + scrollVelocity*(tileInteraction.startTime + startDelayTime)
        
        let width = UIScreen.main.bounds.width
        switch tileInteraction.xPosition {
        case ScreenScrollArea.left.rawValue:
            tile.position.x = width/8
        case ScreenScrollArea.middleLeft.rawValue:
            tile.position.x = 3*width/8
        case ScreenScrollArea.middleRight.rawValue:
            tile.position.x = 5*width/8
        case ScreenScrollArea.right.rawValue:
            tile.position.x = 7*width/8
        default:
            tile.position.x = width/2
        }
        
        tileOrbs.append(tile)
        hashes.append(tile.physicsBody!.hash)
        tile.physicsBody?.velocity = CGVector(dx: 0, dy: -scrollVelocity)
        self.addChild(tile)
    }
    
    //MARK: - Private Methods
    private func setupScene() {
        addChildren()
        setupPositions()
        self.backgroundColor = .label
    }
    
    private func addChildren() {
        self.addChild(mainOrb)
        self.addChild(hitLine)
    }
    
    private func setupPositions() {
        mainOrb.position = CGPoint(x: screenCenter.x, y: GameScene.orbYPosition)
        mainOrb.zPosition = 999999
        hitLine.position = CGPoint(x: screenCenter.x, y: GameScene.orbYPosition + mainOrb.radius + 3)
    }
    
    override func update(_ currentTime: TimeInterval) {
        if tileOrbs != [] && !tileOrbs[0].hasTail && tileOrbs[0].position.y < -tileOrbs[0].height{
            tileOrbs[0].removeFromParent()
            tileOrbs.remove(at: 0)
        } else if tileOrbs != [] && tileOrbs[0].hasTail && (tileOrbs[0].position.y + tileOrbs[0].height) < 0 {
            tileOrbs[0].removeFromParent()
            tileOrbs.remove(at: 0)
            hashes = hashes.filter{$0 != tileOrbs[0].physicsBody?.hash}
        }
    }
    
    //MARK: - Touch Methods
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

extension GameScene: SKPhysicsContactDelegate {
    func didBegin(_ contact: SKPhysicsContact) {
        guard let delegate = gameDelegate else {return}
        let tileBody = contact.bodyA.categoryBitMask == GameSceneCattegoryTypes.tileOrb.rawValue ? contact.bodyA : contact.bodyB
        
        if hashes.contains(tileBody.hash){
            let tile = tileBody.node as! TileOrbNode
            
            if tile.hasTail {
                tileKiteContactStartTime = delegate.getElapsedTime()
            } else {
                score += tile.tileInteraction.minimumScore
                hashes = hashes.filter{$0 != tileBody.hash}
            }
        }
    }
    
    func didEnd(_ contact: SKPhysicsContact) {
        guard let delegate = gameDelegate else {return}
        let tileBody = contact.bodyA.categoryBitMask == GameSceneCattegoryTypes.tileOrb.rawValue ? contact.bodyA : contact.bodyB
        
        //Only the tiles with kite Tail enters this if
        if hashes.contains(tileBody.hash){
            let tile = tileBody.node as! TileOrbNode
            let actualTime = delegate.getElapsedTime()
            score += 2 * tile.tileInteraction.minimumScore * (actualTime - tileKiteContactStartTime)
            tileKiteContactStartTime = 0
        }
    }
}
