//
//  SmileToUnlockController.swift
//  RhythMage
//
//  Created by Bruna Costa on 09/10/21.
//

import UIKit
import ARKit
import AVFoundation
import GameKit
import Photos



class SmileToUnlockController: BaseViewController<SmileToUnlockView> {
    
    //MARK: Injected Properties
    typealias Factory = SongLibrarySceneFactory & SettingsSceneFactory & GameSceneFactory
    let factory: Factory
    let authenticationController: AuthenticationController
    let faceTrackingController: FaceTrackingController
    let audioController: AudioController
    var level: Level
    
    ///camera capture
    var captureSession: AVCaptureSession!
    var stillImageOutput: AVCapturePhotoOutput!
    var videoPreviewLayer: AVCaptureVideoPreviewLayer!
    
    //MARK: Properties
    var progressTime: Double = 0
    var initiatedGameScene = false
    
    /// Tells whether the face tracking is supported on a device(currently it's only for iPhone X).
    /// Please check before creating this view controller!
    static public var isSupported: Bool {
        return ARFaceTrackingConfiguration.isSupported
    }
    
    var ableToPlay = false
    
    //MARK: Initialization
    init (factory: Factory, authenticationController: AuthenticationController, audioController: AudioController, facetrackingController: FaceTrackingController, level: Level) {
        self.factory = factory
        self.audioController = audioController
        self.authenticationController = authenticationController
        self.faceTrackingController = facetrackingController
        self.level = level
        super.init(mainView: SmileToUnlockView())
        mainView.delegate = self
        authenticationController.observers.append(self)
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - View Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupNavigationController()
        if let navigation = navigationController {
            authenticationController.authenticateGKLocalPlayer(navigationController: navigation)
        }
        
        switch AVCaptureDevice.authorizationStatus(for: .video) {
        case .authorized: // The user has previously granted access to the camera.
            print("SYSTEM RESPONSE: This device's camera authorization was already granted.")
            return
        case .notDetermined: // The user has not yet been asked for camera access.
            AVCaptureDevice.requestAccess(for: .video) { _ in
            }
        case .denied: // The user has previously denied access.
            return
        case .restricted: // The user can't grant access due to restrictions.
            return
        @unknown default:
            fatalError("This case should't exist")
        }


    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setupNavigationController()
        initiatedGameScene = false
        mainView.progressView.setProgress(0, animated: false)
        mainView.setBestScore(score: authenticationController.user.completed[authenticationController.user.currentlevel] ?? "0")
    
        audioController.updateUrl(fileName: level.fileName, fileType: level.fileType)
        audioController.start(playing: true)
        audioController.playerVolume(myVolume: 0.3)
        setupFaceTracking()
        
        // TO-DO: Request model from the proper user and level!
        mainView.requestModel(user: authenticationController.user, level: Level.mockedLevel(id: authenticationController.user.currentlevel))
    }
    
    override func viewDidAppear(_ animated: Bool) {
        setupNavigationController()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        self.audioController.pause()
        faceTrackingController.kill()
    }

    //MARK: - NavigationController
    func setupNavigationController() {
        self.navigationController?.setNavigationBarHidden(false, animated: true)
        self.navigationItem.rightBarButtonItem = self.mainView.buttonSettings
        self.navigationItem.leftBarButtonItem = self.mainView.leaderboardButton
    }
}

//MARK: - FaceTracking Delegate
extension SmileToUnlockController: FaceTrackingControllerDelegate {
    
    func setupFaceTracking() {
        mainView.addSubview(faceTrackingController)
        faceTrackingController.initialConfiguration()
        faceTrackingController.isEnabled = true
        faceTrackingController.isViewHidden = false
        faceTrackingController.delegates.append(self)
        faceTrackingController.addTrackedFaces(faces: [.mouthSmileLeft])
    }
    
    func faceRecognized(face: ARFaceAnchor.BlendShapeLocation) {}
    
    func faceHeld(face: ARFaceAnchor.BlendShapeLocation, for time: Double) {
        DispatchQueue.main.async {
                self.mainView.progressView.setProgress(Float(time/2), animated: true)
        }
        if !initiatedGameScene && time >= 2 {
            initiatedGameScene = true
            DispatchQueue.main.async {
                self.navigationController?.pushViewController(self.factory.createGameScene(), animated: true)
                self.faceTrackingController.kill()
                
            }
        }
    }
    
    func faceReleased() {
        DispatchQueue.main.async {
            self.mainView.progressView.setProgress(0, animated: true)
        }
    }
    
}

//MARK: - SmileToUnlockDelegate
extension SmileToUnlockController: SmileToUnlockDelegate {
    
    func onLeaderboardButtonPush() {
        // TO-DO: Add the proper level id!
        authenticationController.openLeaderboard(with: self, with: authenticationController.user.currentlevel)
    }
    
    // Is this function nedded?
    func updateProgressBar() {
        //self.mainView.progressView.setProgress(Float(self.progressTime), animated: true)
    }
    
    
    @objc func onSettingsButtonPush() {
        navigationController?.pushViewController(factory.createSettingsScene(), animated: true)
    }
    
    func onSongLibraryButtonPush() {
        navigationController?.pushViewController(factory.createSongLibraryScene(), animated: true)
    }

    
}

extension SmileToUnlockController: UserObserver {
    func changedCurrentLevel(to level: Level) {
        self.level = level
    }
}
