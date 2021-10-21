//
//  SmileToResumeController.swift
//  RhythMage
//
//  Created by Juliana Prado on 20/10/21.
//

import UIKit
import ARKit

class SmileToResumeViewController: BaseViewController<SmileToResumeView> {
   
    var sceneView: ARSCNView?
    var currentMove: ARFaceAnchor.BlendShapeLocation? = nil
    var progressFloat: CGFloat = 0
    
    var timer: Timer?
    var runCount:Double = 0
    
    typealias Factory = SmileToUnlockSceneFactory
    let factory: Factory
    
    /// Tells whether the face tracking is supported on a device(currently it's only for iPhone X).
    /// Please check before creating this view controller!
    static public var isSupported: Bool {
        return ARFaceTrackingConfiguration.isSupported
    }
    var ableToPlay = false

    init (factory: Factory)
    {
        self.factory = factory
        super.init(mainView: SmileToResumeView())
        mainView.delegate = self
        mainView.layoutSubviews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
      super.viewDidLoad()
        sceneView = ARSCNView(frame: .zero)
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        configureFaceRecognition()
        ableToPlay = true
        
    }
    
    
}

//MARK: - ARSCNViewDelegate
extension SmileToResumeViewController: ARSCNViewDelegate {
    
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
    
    func renderer(_ renderer: SCNSceneRenderer, didUpdate node: SCNNode, for anchor: ARAnchor) {
        if let faceAnchor = anchor as? ARFaceAnchor {
            update(withFaceAnchor: faceAnchor)
        }
    }
    
    @objc func updateCounter(){
        runCount += 0.5
        print(runCount)
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
                
                if self.currentMove == .mouthSmileRight || self.currentMove == .mouthSmileLeft {
                    timer?.invalidate()
                    DispatchQueue.main.async {
                        self.navigationController?.popViewController(animated: true)
                        self.dismiss(animated: true, completion: nil)
                        self.navigationController?.pushViewController(self.factory.createSmileToUnlockScene(), animated: true)
                        self.progressFloat = 0
                        self.runCount = 0
                    }
                }
                
                
                
            }
            
        }
    }
    
}

extension SmileToResumeViewController: SmileToResumeDelegate {
    
    @objc func onMainMenuButtonClicked() {
        navigationController?.popViewController(animated: true)
        dismiss(animated: true, completion: nil)
        let navController = UINavigationController(rootViewController: self.factory.createSmileToUnlockScene())
        navigationController?.present(navController, animated: true, completion: nil)
    }
    
    func updateProgressBar() {
        DispatchQueue.main.async {
            self.mainView.progressView.setProgress(Float(self.progressFloat), animated: true)
        }
    }
    
}
