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

class SmileToUnlockController: BaseViewController<SmileToUnlockView> {
    //MARK: Injected Properties
    typealias Factory = SongLibrarySceneFactory & SettingsSceneFactory & GameSceneFactory
    let factory: Factory
    let authenticationController: AuthenticationController
    let faceTrackingController = FaceTrackingController()
    
    //MARK: Properties
    var progressTime: Double = 0
    var player: AVAudioPlayer!
    var initiatedGameScene = false
    /// Tells whether the face tracking is supported on a device(currently it's only for iPhone X).
    /// Please check before creating this view controller!
    static public var isSupported: Bool {
        return ARFaceTrackingConfiguration.isSupported
    }
    var ableToPlay = false
    
    //MARK: Initialization
    init (factory: Factory, authenticationController: AuthenticationController)
    {
        self.factory = factory
        self.authenticationController = authenticationController
        super.init(mainView: SmileToUnlockView())
        mainView.addSubview(faceTrackingController)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: View Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        mainView.delegate = self
        self.navigationItem.leftBarButtonItem = self.mainView.buttonSettings
        if let navigation = navigationController {
            authenticationController.authenticateGKLocalPlayer(navigationController: navigation)
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        initiatedGameScene = false
        mainView.progressView.setProgress(0, animated: false)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        GKAccessPoint.shared.isActive = true
        Timer.scheduledTimer(timeInterval: 0.5, target: self, selector: #selector(setFaceTrackingController), userInfo: nil, repeats: false)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        GKAccessPoint.shared.isActive = false
    }
    
    @objc private func setFaceTrackingController() {
        faceTrackingController.initialConfiguration()
        faceTrackingController.isEnabled = true
        faceTrackingController.delegates.append(self)
        faceTrackingController.addTrackedFaces(faces: [.mouthSmileLeft])
    }
    
    //MARK: AudioController Methods
    func playSound(){
        guard let path = Bundle.main.path(forResource: mainView.songPlaying, ofType: "mp3") else {
            print("No file.")
            return}
        let url = URL(fileURLWithPath: path)
        do {
            player = try AVAudioPlayer(contentsOf: url)
            guard let player = player else {return}
            player.play()
        }
        catch let error{
            print(error.localizedDescription)
        }
        
    }
}

extension SmileToUnlockController: FaceTrackingControllerDelegate {
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


