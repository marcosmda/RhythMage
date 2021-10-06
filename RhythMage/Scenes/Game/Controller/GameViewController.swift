//
//  GameViewController.swift
//  RhythMage
//
//  Created by Marcos Vinicius Majeveski De Angeli on 01/10/21.
//

import UIKit
import SpriteKit
import GameplayKit

class GameViewController: UIViewController {
    
    init() {
        super.init(nibName: nil, bundle: nil)
        
        // Creates and adds a SKView to be the view for SKScene
        let skView = SKView(frame: self.view.bounds)
        self.view.addSubview(skView)
        
        //Creates and presents the GameScene
        let skScene = GameScene(size: self.view.bounds.size)
        skScene.backgroundColor = .gray
        skView.presentScene(skScene)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
