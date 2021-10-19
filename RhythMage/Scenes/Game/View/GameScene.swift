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

class GameScene: SKScene {
    //MARK: - Properties
    let mainOrb = MainOrbNode(height: 88, color: .pinkOrb)
    let hitLine = HitLineNode(height: 3)
    let screenCenter = CGPoint(x: UIScreen.main.bounds.width/2, y: UIScreen.main.bounds.height/2)
    
    private var currentNode: SKNode?
    
    //MARK: - Initialization
    override init(size: CGSize) {
        super.init(size: size)
        setupScene()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - Methods
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
        let orbYPosition:CGFloat = 80
        mainOrb.position = CGPoint(x: screenCenter.x, y: orbYPosition)
        hitLine.position = CGPoint(x: screenCenter.x, y: orbYPosition + mainOrb.radius + 3)
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
