//
//  GameViewController.swift
//  RhythMage
//
//  Created by Marcos Vinicius Majeveski De Angeli on 01/10/21.
//

import UIKit
import SpriteKit

class GameViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let scene = GameScene()
        
        
        // Present the scene
        if let view = self.view as! SKView? {
            view.presentScene(scene)
            
            view.ignoresSiblingOrder = true
            
            view.showsFPS = true
            view.showsNodeCount = true
        }
    }
        
        override var shouldAutorotate: Bool {
            return true
        }
        
        override var supportedInterfaceOrientations: UIInterfaceOrientationMask {
            if UIDevice.current.userInterfaceIdiom == .phone {
                return .portrait
            } else {
                return .all
            }
        }
        
        override var prefersStatusBarHidden: Bool {
            return true
        }
    }
