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
import AVFoundation

class GameViewController: BaseGameViewController<GameScene, GameView> {
    //MARK: - Properties
    let realm: Realm
    let audioController: AudioController
    let level: Level
    var gameDisplayView: GameDisplayView
    
    let faceTrackingController = FaceTrackingController()
    
    ///camera capture
    var captureSession: AVCaptureSession!
    var stillImageOutput: AVCapturePhotoOutput!
    var videoPreviewLayer: AVCaptureVideoPreviewLayer!
    var images = [UIImage]()
    var counter = 3
    
    //MARK: - Factory
    typealias Factory = SmileToResumeFactory & SummaryFactory
    let factory: Factory
    
    /// Refers to the velocity of the Tiles scrolling
     let scrollVelocity: Double = 300
     let startDelayTime: Double = 3
     var timer: Timer?
     var remainingTime: Double = 0
    /// The height where the center of the HitLineNode is placed
     var hitPoint: CGFloat {
        return GameScene.hitPoint
    }
    
    
    //MARK: - Initialization
    init(realm: Realm, audioController: AudioController, level: Level, factory: Factory) {
        self.realm = realm
        self.audioController = audioController
        self.level = level
        self.gameDisplayView = GameDisplayView()
        self.factory = factory
        let gameScene = GameScene(size: UIScreen.main.bounds.size)
        let gameView = GameView(frame: UIScreen.main.bounds, faceTrackingView: self.faceTrackingController)
        
        //Calls super.init using the screen's frame to create an SKView for the SKScene
        super.init(mainScene: gameScene, mainView: gameView)
        
        //Delegates
        mainScene.gameDelegate = self
        
        self.navigationController?.isNavigationBarHidden = true
        
        initFaceTracking()
        initAudioController()
        initGameDisplayView()
    
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}

