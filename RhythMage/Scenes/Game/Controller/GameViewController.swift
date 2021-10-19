//
//  GameViewController.swift
//  RhythMage
//
//  Created by Marcos Vinicius Majeveski De Angeli on 01/10/21.
//

import UIKit
import SpriteKit
import GameplayKit
import RealmSwift

class GameViewController: BaseGameViewController<GameScene> {
    //MARK: - Properties
    let realm: Realm
    let audioController: AudioController
    let level: Level
    
    //MARK: - Initialization
    init(realm: Realm, audioController: AudioController, level: Level) {
        self.realm = realm
        self.audioController = audioController
        self.level = level
        
        //Calls super.init using teh screen's frame to create an SKView for the SKScene
        super.init(mainScene: GameScene(size: UIScreen.main.bounds.size))
        debugMode(true)
        setupTiles()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - Methods
    func setupTiles() {
        
    }
    
    //MARK: - Debug
    func debugMode(_ bool: Bool) {
        if !bool {return}
        mainView.showsPhysics = true
        mainView.showsNodeCount = true
        mainView.showsFPS = true
    }
}
