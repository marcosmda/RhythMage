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
    var gameView: GameView
    
    ///camera capture
    private var captureSession: AVCaptureSession!
    private var stillImageOutput: AVCapturePhotoOutput!
    private var videoPreviewLayer: AVCaptureVideoPreviewLayer!
    
    //MARK: - Factory
    typealias Factory = SmileToResumeFactory
    let factory: Factory
    
    /// Refers to the velocity of the Tiles scrolling
    private let scrollVelocity: Double = 200
    private let startDelayTime: Double = 5
    private let timerResolution: Double = 0.01
    
    private var timer: Timer?
    private var elapsedTime: Double = 0
    private var isPlaying: Bool = false {
        didSet {
            //if isPlaying {audioController.start()}
        }
    }
    /// The height where the center of the HitLineNode is placed
    private var hitPoint: CGFloat {
        return GameScene.hitPoint
    }
    
    
    //MARK: - Initialization
    init(realm: Realm, audioController: AudioController, level: Level, factory: Factory) {
        self.realm = realm
        self.audioController = audioController
        self.level = level
        self.gameView = GameView()
        self.factory = factory
        
        //Calls super.init using teh screen's frame to create an SKView for the SKScene
        super.init(mainScene: GameScene(size: UIScreen.main.bounds.size))
        
        gameView = GameView(frame: self.mainView.frame)
        gameView.delegate = self
        self.mainView.addSubview(gameView)
        //Delegates
        self.audioController.delegates.append(self)
        mainScene.gameDelegate = self
        
        self.navigationController?.isNavigationBarHidden = true
        //ViewControllerSetup
        debugMode(true)
        setup()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        self.navigationController?.isNavigationBarHidden = true
        setupCameraCaptureSession()
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
        
        for i in 0...4 {
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
    
    private func setupCameraCaptureSession() {
    }
}

extension GameViewController: AudioControllerDelegate {
    func audioFinished() {
        isPlaying = false
    }
}

extension GameViewController: GameSceneDelegate {
    
    func updateCamera(cameraView: UIView) {
        captureSession = AVCaptureSession()
        captureSession.sessionPreset = .medium
        
        guard let frontCamera = AVCaptureDevice.default(.builtInWideAngleCamera, for: .video, position: .front) else { fatalError("no front camera. but don't all iOS 15 devices have them? Check if you are running on the iOS Simulator. You need a physical device ;)") }
        
        do {
            let input = try AVCaptureDeviceInput(device: frontCamera)
            stillImageOutput = AVCapturePhotoOutput()
            if captureSession.canAddInput(input) && captureSession.canAddOutput(stillImageOutput) {
                captureSession.addInput(input)
                captureSession.addOutput(stillImageOutput)

                videoPreviewLayer = AVCaptureVideoPreviewLayer(session: captureSession)
                videoPreviewLayer.videoGravity = .resizeAspectFill
                videoPreviewLayer.connection?.videoOrientation = .portrait
                cameraView.layer.insertSublayer(videoPreviewLayer, at: 0)
                
                DispatchQueue.global(qos: .userInitiated).async { [weak self] in
                    self?.captureSession.startRunning()
                    DispatchQueue.main.async {
                        self?.videoPreviewLayer.frame = cameraView.bounds
                    }
                }
                
            }
        }
        catch let error  {
            print("Error Unable to initialize front camera:  \(error.localizedDescription)")
        }

    }
    
    func getElapsedTime() -> Double {
        return self.elapsedTime
    }
    
    func pauseGame() {
        let vc = factory.createSmileToResumeScene()
        vc.modalPresentationStyle = .overCurrentContext
        vc.modalTransitionStyle = .crossDissolve
        present(vc, animated: true, completion: nil)
    }
}
