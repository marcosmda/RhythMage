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
    case faceExpression = 0x3
    case tileOrb = 0x4
}

protocol GameSceneDelegate {
    func getElapsedTime() 
    func pauseGame()
    func updatedScore(score: Double)
    func updateCamera(cameraView: UIView)
}

class GameScene: SKScene {
    //MARK: - Properties
    static let mainOrbHeight: CGFloat = 88
    static let orbYPosition: CGFloat = 80
    static var hitPoint: CGFloat {
        return orbYPosition + MainOrbNode.heightToRadiusCte*mainOrbHeight/2 + 3
    }
    
    let mainOrb = MainOrbNode(height: GameScene.mainOrbHeight, color: .pinkOrb)
    let hitLine = HitLineNode(height: 150)
    let screenCenter = CGPoint(x: UIScreen.main.bounds.width/2, y: UIScreen.main.bounds.height/2)
   
    //MARK: - Facial Expressions Circles
    let middleFaceExpression = FaceExpressionNode(height: 30, position: .middle)
    let rightFaceExpression = FaceExpressionNode(height: 30, position: .right)
    let leftFaceExpression = FaceExpressionNode(height: 30, position: .left)
    var facialExpressions: [FaceExpressionNode] = []
    
    var tileOrbs = [TileOrbNode]()
    var hashes = [Int]()
    var score: Double = 0 
    var gameDelegate: GameSceneDelegate?
    
    var currentNode: SKNode?
    var tileKiteContactStartTime: Double = 0
    var lastUpdateTimeInterval = TimeInterval()          // simply a Double
    var lastYieldTimeInterval = TimeInterval()
    //The array of tiles that are currently on contact, containing the hash of each one and teh node
    var tilesInContact = [Int: TileOrbNode]()
    
    //MARK: - Initialization
    override init(size: CGSize) {
        super.init(size: size)
        initContactDelegate()
        facialExpressions = [leftFaceExpression, middleFaceExpression, rightFaceExpression]
        setupScene()
        
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func update(_ currentTime: TimeInterval) {
        var timeSinceLastUpdate = currentTime - lastUpdateTimeInterval     // The name means it: time since last update
               lastUpdateTimeInterval = currentTime
           
               if timeSinceLastUpdate > 1 {          // Did we wait for more than 1 (s or minutes ?) ?
                   timeSinceLastUpdate = 1/60
                   lastUpdateTimeInterval = currentTime
               }
           
               updateWithTimeSinceLastUpdate(timeSinceLastUpdate: timeSinceLastUpdate)
        
        //MARK: With time interval it enters, but stops after first right face
        if tileOrbs != [] && !tileOrbs[0].hasTail && tileOrbs[0].position.y < -tileOrbs[0].height{
            tileOrbs[0].removeFromParent()
            tileOrbs.remove(at: 0)
            print("entrei perdeu")
            hitLine.handleFillColors(with: .failure)
            
            //MARK: Not entering
        } else if tileOrbs != [] && tileOrbs[0].hasTail && (tileOrbs[0].position.y - tileOrbs[0].height) < 0 { //was +
            tileOrbs[0].removeFromParent()
            tileOrbs.remove(at: 0)
            hashes = hashes.filter{$0 != tileOrbs[0].physicsBody?.hash}
            print("entrei acertou")
            hitLine.handleFillColors(with: .successuful)
        }
        
        gameDelegate?.getElapsedTime()
    }
    func updateWithTimeSinceLastUpdate(timeSinceLastUpdate: CFTimeInterval)  {
        lastYieldTimeInterval += timeSinceLastUpdate
        if lastYieldTimeInterval > 0.6 {     // time out of 0.6 s
            lastYieldTimeInterval = 0
       
        }
    }

    
}

