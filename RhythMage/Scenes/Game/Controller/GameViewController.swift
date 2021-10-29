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

class GameViewController: BaseGameViewController<GameScene> {
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
     let scrollVelocity: Double = 400
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
        
        //Calls super.init using the screen's frame to create an SKView for the SKScene
        super.init(mainScene: GameScene(size: UIScreen.main.bounds.size))
        
        gameDisplayView = GameDisplayView(frame: self.mainView.frame)
        gameDisplayView.delegate = self
        self.mainView.addSubview(gameDisplayView)
        //Delegates
        mainScene.gameDelegate = self
        
        
        self.navigationController?.isNavigationBarHidden = true
        
        initFaceTracking()
        
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
        timer = Timer.scheduledTimer(timeInterval: startDelayTime, target: self, selector: #selector(startAudio), userInfo: nil, repeats: false)
        mainScene.setVelocity(velocity: Float(scrollVelocity))
    }
    
    override func viewDidLayoutSubviews() {
        
        let position = mainScene.convertPoint(toView: CGPoint(x: mainScene.hitLine.position.x, y: mainScene.hitLine.position.y))
        
        let width = mainView.frame.width - 20
        let height: CGFloat = 23.00
        
        gameDisplayView.hitBarImage.frame = CGRect(x: position.x - width/2, y:  position.y - height / 2, width: width, height: height)
        
    }
    
    //MARK: - Methods
    private func setup() {
        setupAudioController()
    }
    
    

    private func createTiles() {
        guard let interactionSequence = level.sequences.first else{return}
        
        for interaction in interactionSequence.sequence {
            guard let tile = interaction as? TileInteraction else {break}
            mainScene.addTileOrb(tile: tile, scrollVelocity: scrollVelocity, startDelayTime: startDelayTime)
        }
    }
    
    //MARK: - Private Methods
    
    
    @objc func takePrint() {
        if counter > 0 {
            stillImageOutput.capturePhoto(with: AVCapturePhotoSettings(), delegate: self)
            counter -= 1
        }
    }
    
    func toggleGameStatus() {
        if !mainScene.isPaused {
            mainScene.isPaused = true
            audioController.pause()
            if timer != nil {
                remainingTime = timer?.fireDate.timeIntervalSince(Date()) ?? 3
                timer?.invalidate()
                timer = nil
            }
            
        } else if mainScene.isPaused {
            if timer == nil {
                timer = Timer.scheduledTimer(timeInterval: remainingTime, target: self, selector: #selector(startAudio), userInfo: nil, repeats: false)
                mainScene.isPaused = false
            } else {
                mainScene.isPaused = false
                audioController.play()
            }
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

extension GameViewController: AVCapturePhotoCaptureDelegate {
    func photoOutput(_ output: AVCapturePhotoOutput,
                                     didFinishProcessingPhoto photo: AVCapturePhoto,
                                     error: Error?)
    {
        // capture image finished
        print("Image captured.")

        guard let imageData = photo.fileDataRepresentation() else {return}
        guard let uiImage = UIImage(data: imageData) else {return}
        images.append(uiImage)
    }
}
