//
//  GameViewController.swift
//  RhythMage
//
//  Created by Marcos Vinicius Majeveski De Angeli on 01/10/21.
//

import UIKit
import SpriteKit
import GameplayKit

class GameViewController: BaseGameViewController<SKView> {
    
    //MARK: - Initialization
    init() {
        //Calls super.init using teh screen's frame to create an SKView for the SKScene
        super.init(mainView: SKView(frame: UIScreen.main.bounds))
        
        //Creates and presents the GameScene
        let skScene = GameScene(size: self.view.bounds.size)
        skScene.backgroundColor = .gray
        mainView.presentScene(skScene)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
