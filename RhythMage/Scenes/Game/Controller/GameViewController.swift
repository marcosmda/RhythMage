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
    var gameDisplayView: GameDisplayView
    
    typealias Factory = SmileToResumeFactory & SummaryFactory
    let factory: Factory
    
    /// Refers to the velocity of the Tiles scrolling
    private let scrollVelocity: Double = 400
    private let startDelayTime: Double = 3
    
    /// The height where the center of the HitLineNode is placed
    private var hitPoint: CGFloat {
        return GameScene.hitPoint
    }
    
    
    //MARK: - Initialization
    init(realm: Realm, audioController: AudioController, level: Level, factory: Factory) {
        self.realm = realm
        self.audioController = audioController
        self.level = level
        self.gameDisplayView = GameDisplayView()
        self.factory = factory
        
        //Calls super.init using the screen's frame to create an SKView for the SKScene
        super.init(mainScene: GameScene(size: UIScreen.main.bounds.size))
        
        gameDisplayView = GameDisplayView(frame: self.mainView.frame)
        gameDisplayView.delegate = self
        self.mainView.addSubview(gameDisplayView)
        //Delegates
        self.audioController.delegates.append(self)
        mainScene.gameDelegate = self
        
        
        self.navigationController?.isNavigationBarHidden = true
        
        //ViewControllerSetup
        debugMode(false)
        setup()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        self.navigationController?.isNavigationBarHidden = true
        
        createTiles()
        Timer.scheduledTimer(timeInterval: startDelayTime, target: self, selector: #selector(startAudio), userInfo: nil, repeats: false)
        mainScene.setVelocity(velocity: Float(scrollVelocity))
    }
    
    //MARK: - Methods
    private func setup() {
        setupAudioController()
    }
    
    private func setupAudioController() {
        audioController.updateUrl(fileName: "fairy-tale-waltz", fileType: "mp3")
        audioController.start(playing: false)
    }

    private func createTiles() {
        guard let interactionSequence = level.sequences.first else{return}
        
        for interaction in interactionSequence.sequence {
            guard let tile = interaction as? TileInteraction else {break}
            mainScene.addTileOrb(tile: tile, scrollVelocity: scrollVelocity, startDelayTime: startDelayTime)
        }
    }
    
    //MARK: - Private Methods
    @objc private func startAudio() {
        audioController.play()
    }
    
    private func toggleGameStatus() {
        guard let scene = mainView.scene else {return}
        if !scene.isPaused {
            mainView.scene?.isPaused = true
            audioController.pause()
        } else if scene.isPaused {
            mainView.scene?.isPaused = false
            audioController.play()
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
        DispatchQueue.main.async {
            self.navigationController?.pushViewController(self.factory.createSummaryScene(), animated: true)
        }
    }
}

extension GameViewController: GameSceneDelegate {
    func getElapsedTime() -> Double? {
        return audioController.getPlayerTime()
    }
    
    func pauseGame() {
        guard let navController = self.navigationController else {return}
        let vc = factory.createSmileToResumeScene(rootNavigationController: navController)
        vc.delegate = self
        vc.modalPresentationStyle = .overCurrentContext
        vc.modalTransitionStyle = .crossDissolve
        DispatchQueue.main.async {
            self.present(vc, animated: true, completion: nil)
            self.toggleGameStatus()
        }
    }
    
    func updatedScore(score: Double) {
        gameDisplayView.song.pointsLabel.text = String(Int(score))
    }
}

extension GameViewController: SmileToResumeDelegate {
    func resumed() {
        audioController.start(playing: true)
        toggleGameStatus()
    }
}
