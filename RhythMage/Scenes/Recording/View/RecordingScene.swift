//
//  RecordingView.swift
//  RhythMage
//
//  Created by Marcos Vinicius Majeveski De Angeli on 13/10/21.
//

import SpriteKit
import GameplayKit

enum ScreenAreaButtons: String {
    case leftButton
    case middleLeftButton
    case middleRightButton
    case rightButton
    case pauseButton
}

protocol RecordingSceneDelegate {
    func pauseButtonTouched()
}

class RecordingScene: SKScene {
    //MARK: - Properties
    var tileInteractions = [RealmTileInteraction]()
    var initialTime: TimeInterval = 0
    var nowTime: TimeInterval = 0
    var elapsedTime: TimeInterval = 0
    var sceneDelegate: RecordingSceneDelegate?
    
    //MARK: - View Properties
    var leftButton: SKShapeNode {
        let node = SKShapeNode(rect: CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width/4, height: 120))
        node.fillColor = .green
        node.strokeColor = .clear
        node.name = ScreenAreaButtons.leftButton.rawValue
        return node
    }
    
    var middleLeftButton: SKShapeNode {
        let node = SKShapeNode(rect: CGRect(x: UIScreen.main.bounds.width/4, y: 0, width: UIScreen.main.bounds.width/4, height: 120))
        node.fillColor = .blue
        node.strokeColor = .clear
        node.name = ScreenAreaButtons.middleLeftButton.rawValue
        return node
    }
    
    var middleRightButton: SKShapeNode {
        let node = SKShapeNode(rect: CGRect(x: 2*UIScreen.main.bounds.width/4, y: 0, width: UIScreen.main.bounds.width/4, height: 120))
        node.fillColor = .red
        node.strokeColor = .clear
        node.name = ScreenAreaButtons.middleRightButton.rawValue
        return node
    }
    
    var rightButton: SKShapeNode {
        let node = SKShapeNode(rect: CGRect(x: 3*UIScreen.main.bounds.width/4, y: 0, width: UIScreen.main.bounds.width/4, height: 120))
        node.fillColor = .white
        node.strokeColor = .clear
        node.name = ScreenAreaButtons.rightButton.rawValue
        return node
    }
    
    var pauseButton: SKShapeNode {
        let node = SKShapeNode(circleOfRadius: 50)
        node.position = CGPoint(x: UIScreen.main.bounds.width/2, y: UIScreen.main.bounds.height/2)
        node.fillColor = .brown
        node.strokeColor = .clear
        node.name = ScreenAreaButtons.pauseButton.rawValue
        return node
    }
    
    override func sceneDidLoad() {
        self.addChild(leftButton)
        self.addChild(middleLeftButton)
        self.addChild(middleRightButton)
        self.addChild(rightButton)
        self.addChild(pauseButton)
    }
    
    override func update(_ currentTime: TimeInterval) {
        // Called before each frame is rendered
        setupTimer(currentTime)
    } 
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        guard let touch = touches.first as UITouch? else {return}
        let touchLocation = touch.location(in: self)
        let targetNode = atPoint(touchLocation)
        
        switch targetNode.name {
        case ScreenAreaButtons.leftButton.rawValue:
            createTile(area: .left)
        case ScreenAreaButtons.middleLeftButton.rawValue:
            createTile(area: .middleLeft)
        case ScreenAreaButtons.middleRightButton.rawValue:
            createTile(area: .middleRight)
        case ScreenAreaButtons.rightButton.rawValue:
            createTile(area: .right)
        case ScreenAreaButtons.pauseButton.rawValue:
            guard let delegate = sceneDelegate else {break}
            delegate.pauseButtonTouched()
        default:
            break
        }
        
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        guard let touch = touches.first as UITouch? else {return}
        let touchLocation = touch.location(in: self)
        let targetNode = atPoint(touchLocation)
        
        switch targetNode.name {
        case ScreenAreaButtons.leftButton.rawValue, ScreenAreaButtons.middleLeftButton.rawValue, ScreenAreaButtons.middleRightButton.rawValue, ScreenAreaButtons.rightButton.rawValue:
            updateEndTime()
        default:
            break
        }
    }
    
    func createTile(area: ScreenScrollArea) {
        let tile = RealmTileInteraction()
        tile.minimumScore = 10
        tile.xPosition = area.rawValue
        tile.startTime = elapsedTime
        tileInteractions.append(tile)
    }
    
    func updateEndTime() {
        guard tileInteractions.last?.endTime != nil else {return}
        tileInteractions.last?.endTime = elapsedTime
    }
    
    func setupTimer(_ currentTime: TimeInterval) {
        if initialTime == 0 {
            initialTime = currentTime
        }
        nowTime = currentTime
        elapsedTime = nowTime - initialTime
    }
}
