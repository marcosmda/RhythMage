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
    var audioController: AudioController
    let level: Level
    
    private let startDelayTime: Double = 5
    private let timerResolution: Double = 0.01
    private var timer: Timer?
    var elapsedTime: Double = 0
    private var isPlaying: Bool = false {
        didSet {
            if isPlaying {audioController.start()}
        }
    }
    /// The height where the center of the HitLineNode is placed
    private var hitPoint: CGFloat {
        return GameScene.hitPoint
    }
    /// Refers to the velocity of the Tiles scrolling
    private var scrollVelocity: Double {
        return Double(UIScreen.main.bounds.height - hitPoint)/startDelayTime
    }
    
    //MARK: - Initialization
    init(realm: Realm, audioController: AudioController, level: Level) {
        self.realm = realm
        self.audioController = audioController
        self.level = level
        
        //Calls super.init using teh screen's frame to create an SKView for the SKScene
        super.init(mainScene: GameScene(size: UIScreen.main.bounds.size))
        
        //Delegates
        self.audioController.delegates.append(self)
        
        mainScene.physicsWorld.contactDelegate = self
        //ViewControllerSetup
        debugMode(true)
        setup()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - Methods
    func setup() {
        setupAudioController()
        createTiles()
        setTimer()
    }
    
    func setupAudioController() {
        audioController.updateUrl(fileName: "fairy-tale-waltz", fileType: "mp3")
    }

    func createTiles() {
        guard let interactionSequence = level.sequences.first else{return}
        
        var smallerInteraction = [InteractionProtocol]()
        
        for i in 0...19 {
            smallerInteraction.append(interactionSequence.sequence[i])
        }
        
        for interaction in smallerInteraction {
            guard let tile = interaction as? TileInteraction else {break}
            
            mainScene.addTileOrb(tile: tile, scrollVelocity: scrollVelocity, startDelayTime: startDelayTime)
        }
    }
    
    //MARK: - Private Methods
    private func setTimer() {
        timer = Timer.scheduledTimer(timeInterval: timerResolution, target: self, selector: #selector(updateElapsedTime), userInfo: nil, repeats: true)
    }
    
    @objc private func updateElapsedTime() {
        elapsedTime += 0.01
        
        //Check for song start
        if !isPlaying && elapsedTime >= startDelayTime{
            isPlaying = true
        }
    }
    
    //MARK: - Debug
    private func debugMode(_ bool: Bool) {
        if !bool {return}
        mainView.showsPhysics = true
        mainView.showsNodeCount = true
        mainView.showsFPS = true
    }
}

extension GameViewController: AudioControllerDelegate {
    func audioFinished() {
        
    }
}

extension GameViewController: SKPhysicsContactDelegate {
    func didBegin(_ contact: SKPhysicsContact) {
        //print(elapsedTime)
    }
}
