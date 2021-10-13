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

protocol SmileToUnlockDelegate {
    func onSettingsButtonPush()
    func onGameCenterButtonPush()
    func onSongLibraryButtonPush()
}

class SmileToUnlockController: BaseViewController<SmileToUnlockView>, ARSCNViewDelegate{
    
    //public var smileView: SmileToUnlockView!
    
    var timer = Timer()
    
    var runCount:Double = 0
    
    var player: AVAudioPlayer!
    
    var sceneView: ARSCNView?
    var currentMove: ARFaceAnchor.BlendShapeLocation? = nil
    
    var ableToPlay = false
    
    typealias Factory = MainSceneFactory
    
    let factory: Factory
    
    /// Tells whether the face tracking is supported on a device(currently it's only for iPhone X).
    /// Please check before creating this view controller!
    static public var isSupported: Bool {
        return ARFaceTrackingConfiguration.isSupported
    }
    /// Action to do after a user has smiled
    public var onSuccess: (() -> Void)?
    
    /// Set how much smile do you need from a user. 0.8 is kind of hard already!
    public var successTreshold: CGFloat = 0.6
    
    private var userSmiled = false
    
    init (factory: Factory)
    {
        self.factory = factory
        super.init(mainView: SmileToUnlockView())
        mainView.delegate = self
        mainView.layoutSubviews()
        setupGameKit()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    override func viewDidLoad() {
      super.viewDidLoad()
        sceneView = ARSCNView(frame: .zero)
        timer = Timer.scheduledTimer(timeInterval: 0.5, target: self, selector: #selector(updateCounter), userInfo: nil, repeats: true)
        mainView.backgroundColor = .white
        navigationController?.isNavigationBarHidden = true
        //playSound()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        guard ARFaceTrackingConfiguration.isSupported else { print("iPhone X required"); return }
        
        let configuration = ARFaceTrackingConfiguration()
        if #available(iOS 13.0, *) {
            configuration.maximumNumberOfTrackedFaces = ARFaceTrackingConfiguration.supportedNumberOfTrackedFaces
        }
        
        configuration.isLightEstimationEnabled = true
        sceneView?.session.run(configuration, options: [.resetTracking, .removeExistingAnchors])
        sceneView?.delegate = self
    }
    
    @objc func updateCounter(){
        runCount+=0.5
        //print(runCount)
    }
    
    private func configureFaceRecognition() {
        let configuration = ARFaceTrackingConfiguration()
        configuration.isLightEstimationEnabled = true

        let sceneView = ARSCNView(frame: view.bounds)
        mainView.addSubview(sceneView)
        sceneView.automaticallyUpdatesLighting = true
        sceneView.session.run(configuration, options: [.resetTracking, .removeExistingAnchors])
        sceneView.isHidden = true
        //sceneView.delegate = self
    }
    
    override var supportedInterfaceOrientations: UIInterfaceOrientationMask {
        if UIDevice.current.userInterfaceIdiom == .phone {
            return .allButUpsideDown
        } else {
            return .all
        }
    }
    
    // MARK: ARSession Delegate
    func renderer(_ renderer: SCNSceneRenderer, didUpdate node: SCNNode, for anchor: ARAnchor) {
        if let faceAnchor = anchor as? ARFaceAnchor {
            update(withFaceAnchor: faceAnchor)
        }
    }
    
    func update(withFaceAnchor faceAnchor: ARFaceAnchor) {
        
        var selectedMove: ARFaceAnchor.BlendShapeLocation? = nil
        
        let blends: [ARFaceAnchor.BlendShapeLocation] = [.mouthSmileRight, .mouthSmileLeft]
        
        for move in blends {
            guard let faceFactor = faceAnchor.blendShapes[move] as? Float else {return}
            if (faceFactor > 0.7){
                if selectedMove == nil{
                    selectedMove = move
                }
                else{
                    guard let maxFactor = faceAnchor.blendShapes[selectedMove!] as? Float else {return}
                    if faceFactor > maxFactor {
                        selectedMove = move
                    }
                }
            }
        }
        
        if(self.currentMove != selectedMove) {
            
            self.currentMove = selectedMove
            
            if ableToPlay && runCount > 1.5{
                
                if self.currentMove == .mouthSmileRight || self.currentMove == .mouthSmileLeft {
                    navigationController?.pushViewController(factory.createSongLibraryView(), animated: true)
                }
        
    }
        }
    }
    
    func playSound(title: String, type: String){
        guard let path = Bundle.main.path(forResource: title, ofType: type) else {
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
    

extension SmileToUnlockController: SmileToUnlockDelegate {
    func onGameCenterButtonPush() {
        navigationController?.pushViewController(factory.createSongLibraryView(), animated: true)
    }
    
    func onSongLibraryButtonPush() {
        navigationController?.pushViewController(factory.createSongLibraryView(), animated: true)
    }
    
    func onSettingsButtonPush() {
        navigationController?.pushViewController(factory.createSongLibraryView(), animated: true)
    }
}

//MARK: - GameKit Setup
extension SmileToUnlockController {
    
    func setupGameKit() {
        
        GKLocalPlayer.local.authenticateHandler = { viewController, error in
            
            if let viewController = viewController {
                // Present the view controller so the player can sign in.
                
                self.present(viewController, animated: true, completion: nil)
                
                return
            }
            
            if error != nil {
                // Player could not be authenticated.
                // Disable Game Center in the game.
                return
            }
            
            // Player was successfully authenticated.
            // Check if there are any player restrictions before starting the game.
            
            if GKLocalPlayer.local.isUnderage {
                // Hide explicit game content.
            }
            
            if GKLocalPlayer.local.isMultiplayerGamingRestricted {
                // Disable multiplayer game features.
            }
            
            if GKLocalPlayer.local.isPersonalizedCommunicationRestricted {
                // Disable in game communication UI.
            }
            
        }
        
        GKAccessPoint.shared.isActive = true
        
    }
    
    
}
