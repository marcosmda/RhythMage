//
//  GameViewController.swift
//  RhythMage
//
//  Created by Marcos Vinicius Majeveski De Angeli on 01/10/21.
//

import UIKit
import SpriteKit
import GameplayKit

class GameViewController: BaseGameViewController<GameScene> {
    
    //MARK: - Initialization
    init() {
        //Calls super.init using teh screen's frame to create an SKView for the SKScene
        super.init(mainScene: GameScene(size: UIScreen.main.bounds.size))
        
        //Presents the GameScene
        mainScene.backgroundColor = .gray
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
