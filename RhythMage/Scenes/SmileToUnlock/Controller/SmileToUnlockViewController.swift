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

class SmileToUnlockController: BaseViewController<SmileToUnlockView>, ARSCNViewDelegate {
    //MARK: Injected Properties
    typealias Factory = SongLibrarySceneFactory & SmileToResumeFactory & SettingsSceneFactory
    let factory: Factory
    let authenticationController: AuthenticationController
    
    //MARK: Properties
    //public var smileView: SmileToUnlockView!
    
    var progressFloat: CGFloat = 0
    
    var timer: Timer?
    var runCount:Double = 0
    var player: AVAudioPlayer!
    
    var sceneView: ARSCNView?
    var currentMove: ARFaceAnchor.BlendShapeLocation? = nil

    
    
    /// Tells whether the face tracking is supported on a device(currently it's only for iPhone X).
    /// Please check before creating this view controller!
    static public var isSupported: Bool {
        return ARFaceTrackingConfiguration.isSupported
    }
    var ableToPlay = false

    init (factory: Factory, authenticationController: AuthenticationController)
    {
        self.factory = factory
        self.authenticationController = authenticationController
        super.init(mainView: SmileToUnlockView())
        
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
      super.viewDidLoad()
        sceneView = ARSCNView(frame: .zero)
        mainView.delegate = self
        configureFaceRecognition()
        self.navigationItem.leftBarButtonItem = self.mainView.buttonSettings
        if let navigation = navigationController {
            authenticationController.authenticateGKLocalPlayer(navigationController: navigation)
        }
        
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        ableToPlay = true
  
    }
    
    override func viewDidAppear(_ animated: Bool) {
             super.viewDidAppear(animated)
        GKAccessPoint.shared.isActive = true
    }

    override func viewWillDisappear(_ animated: Bool) {
        GKAccessPoint.shared.isActive = false
    }
    
    @objc func updateCounter(){
        runCount += 0.5
        print(runCount)
    }
    
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
    
    private func configureFaceRecognition() {
        
        guard ARFaceTrackingConfiguration.isSupported else { print("iPhone X required"); return }
        
        let configuration = ARFaceTrackingConfiguration()
        configuration.isLightEstimationEnabled = true
        
        if #available(iOS 13.0, *) {
            configuration.maximumNumberOfTrackedFaces = ARFaceTrackingConfiguration.supportedNumberOfTrackedFaces
        }

        let sceneView = ARSCNView(frame: view.bounds)
        mainView.addSubview(sceneView)
        sceneView.automaticallyUpdatesLighting = true
        sceneView.session.run(configuration, options: [.resetTracking, .removeExistingAnchors])
        sceneView.isHidden = true
        sceneView.delegate = self
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
                if selectedMove == nil {
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
                
            timer = Timer.scheduledTimer(timeInterval: TimeInterval(0.5), target: self, selector: #selector(self.updateCounter), userInfo: nil, repeats: true)
          
            self.progressFloat = 1.0
            self.updateProgressBar()
            
            self.currentMove = selectedMove
            
            if ableToPlay && runCount > 1.0 {
                
                print("ENTREI")
                if self.currentMove == .mouthSmileRight || self.currentMove == .mouthSmileLeft {
                    timer?.invalidate()
                    DispatchQueue.main.async {
                        print("ENTREI")
                        self.navigationController?.pushViewController(self.factory.createSongLibraryScene(), animated: true)
                        self.progressFloat = 0
                        self.runCount = 0
                    }
                }
                
                
                
            }
            
        }
    }
                                                            

}


extension SmileToUnlockController: SmileToUnlockDelegate {
    
    func updateProgressBar() {
        DispatchQueue.main.async {
            self.mainView.progressView.setProgress(Float(self.progressFloat), animated: true)
        }
    }
    
    
    @objc func onSettingsButtonPush() {
        //let vc = factory.createSmileToResumeScene()
        /*let vc = factory.createSett()
        vc.modalPresentationStyle = .overCurrentContext
        vc.modalTransitionStyle = .crossDissolve
        present(vc, animated: true, completion: nil)*/
        let navController = UINavigationController(rootViewController: factory.createSettingsScene())
        navigationController?.pushViewController(factory.createSettingsScene(), animated: true)
    }
    
    
    func onSongLibraryButtonPush() {
        navigationController?.pushViewController(factory.createSongLibraryScene(), animated: true)
    }

}


