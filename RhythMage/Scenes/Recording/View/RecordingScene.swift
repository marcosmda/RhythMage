//
//  RecordingView.swift
//  RhythMage
//
//  Created by Marcos Vinicius Majeveski De Angeli on 13/10/21.
//

import SpriteKit
import GameplayKit

class RecordingScene: SKScene {
    //MARK: - Properties
    var tileInteractions = [TileInteraction]()
    var elapsedTime = DispatchTime.now()
    
    //MARK: - View Properties
    var leftButton: SKShapeNode {
        let node = SKShapeNode(rect: CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width/4, height: 120))
        node.fillColor = .green
        node.strokeColor = .clear
        node.name = "rightButton"
        return node
    }
    
    var middleLeftButton: SKShapeNode {
        let node = SKShapeNode(rect: CGRect(x: UIScreen.main.bounds.width/4, y: 0, width: UIScreen.main.bounds.width/4, height: 120))
        node.fillColor = .blue
        node.strokeColor = .clear
        node.name = "rightButton"
        return node
    }
    
    var middleRightButton: SKShapeNode {
        let node = SKShapeNode(rect: CGRect(x: 2*UIScreen.main.bounds.width/4, y: 0, width: UIScreen.main.bounds.width/4, height: 120))
        node.fillColor = .red
        node.strokeColor = .clear
        node.name = "rightButton"
        return node
    }
    
    var rightButton: SKShapeNode {
        let node = SKShapeNode(rect: CGRect(x: 3*UIScreen.main.bounds.width/4, y: 0, width: UIScreen.main.bounds.width/4, height: 120))
        node.fillColor = .white
        node.strokeColor = .clear
        node.name = "rightButton"
        node.isUserInteractionEnabled = true
        return node
    }
    
    override func sceneDidLoad() {
        self.addChild(leftButton)
        self.addChild(middleLeftButton)
        self.addChild(middleRightButton)
        self.addChild(rightButton)
    }
    
    override func update(_ currentTime: TimeInterval) {
        // Called before each frame is rendered
        
    }
    
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        guard let touch = touches.first as UITouch? else {return}
        let touchLocation = touch.location(in: self)
        let targetNode = atPoint(touchLocation)
        
        switch targetNode.name {
        case "rightButton":
            tileInteractions.append(TileInteraction(minimumScore: 10, xPosition: .right,
                                                    startTime: Double(elapsedTime.uptimeNanoseconds/1000000000),
                                                    endTime: Double(elapsedTime.uptimeNanoseconds/1000000000)))
            
        case .none:
            break
        case .some(_):
            break
        }
        
    }
}
