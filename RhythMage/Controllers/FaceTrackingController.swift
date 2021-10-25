//
//  FaceTrackingController.swift
//  RhythMage
//
//  Created by Marcos Vinicius Majeveski De Angeli on 25/10/21.
//

import ARKit
import UIKit

protocol FaceTrackingControllerDelegate {
    
    /// The method to be called when a face was recognized as predominant
    /// - Parameter face: The face that was predominant
    func faceRecognized(face: ARFaceAnchor.BlendShapeLocation)
    
    /// The method to be called when a face was recognized as predominant and held by an amout of time
    /// - Parameter face: The face that was predominant
    func faceHeld(face: ARFaceAnchor.BlendShapeLocation, for time: Double)
}

class FaceTrackingController: UIView {
    
    var sceneView: ARSCNView?
    var predominantFace: ARFaceAnchor.BlendShapeLocation?
    
    var heldUpdateRate: Double = 2
    var factorValue: Float = 0.7
    var delegates = [FaceTrackingControllerDelegate]()
    
    private let timerResolution: Double = 0.1
    private var trackedFaces = [ARFaceAnchor.BlendShapeLocation]()
    private var heldTime: Double = 0
    private var timer: Timer?
    
    //MARK: Initialization
    init() {
        super.init(frame: CGRect(x: 0, y: 0, width: 100, height: 100))
        initialConfiguration()
        sceneView?.delegate = self
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: Configuration Methods
    private func initialConfiguration() {
        guard ARFaceTrackingConfiguration.isSupported else { fatalError("iPhone X required") }
        let arScene = ARSCNView(frame: self.frame)
        let configuration = ARFaceTrackingConfiguration()
        
        configuration.isLightEstimationEnabled = true
        if #available(iOS 13.0, *) {
            configuration.maximumNumberOfTrackedFaces = ARFaceTrackingConfiguration.supportedNumberOfTrackedFaces
        }
        
        arScene.automaticallyUpdatesLighting = true
        arScene.session.run(configuration, options: [.resetTracking, .removeExistingAnchors])
        arScene.isHidden = true
        arScene.delegate = self
        sceneView = arScene
        guard sceneView != nil else {fatalError("Could not create a Face Tracking Controller")}
        addSubview(sceneView!)
    }
    
    //MARK: Timer Methods
    
    @objc func timerUpdate() {
        heldTime += timerResolution
    }
    
    //MARK: Set Methods
    
    func addTrackedFaces(faces: [ARFaceAnchor.BlendShapeLocation]) {
        for face in faces {
            if !trackedFaces.contains(face) {
                trackedFaces.append(face)
            }
        }
    }
    
    func removeTrackedFaces(faces: [ARFaceAnchor.BlendShapeLocation]) {
        for face in faces {
            if trackedFaces.contains(face) {
                trackedFaces = trackedFaces.filter{$0 != face}
            }
        }
    }

}

extension FaceTrackingController: ARSCNViewDelegate {
    
    func renderer(_ renderer: SCNSceneRenderer, didUpdate node: SCNNode, for anchor: ARAnchor) {
        if let faceAnchor = anchor as? ARFaceAnchor {
            update(with: faceAnchor)
        }
    }
    
    private func update(with faceAnchor: ARFaceAnchor) {
        var highestFactor: Float = 0
        var highestFace: ARFaceAnchor.BlendShapeLocation?  //MOCKADO
        
        for face in trackedFaces {
            guard let faceFactor = faceAnchor.blendShapes[face] as? Float else {return}
            if faceFactor > highestFactor && faceFactor > factorValue{
                highestFactor = faceFactor
                highestFace = face
            }
            
            if face == predominantFace && faceFactor < factorValue {
                heldTime = 0
                timer?.invalidate()
            }
        }
        
        guard let highestFace = highestFace else {return}
        if predominantFace != highestFace {
            predominantFace = highestFace
            heldTime = 0
            timer?.invalidate()
            timer = Timer.scheduledTimer(timeInterval: 0.1, target: self, selector: #selector(timerUpdate), userInfo: nil, repeats: true)
        }
        
        
        for delegate in delegates {
            delegate.faceRecognized(face: highestFace)
        }
        
        if heldTime >= heldUpdateRate {
            for delegate in delegates {
                delegate.faceHeld(face: highestFace, for: heldTime)
            }
            heldTime = 0
        }
    }
}
