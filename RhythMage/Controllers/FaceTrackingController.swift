//
//  FaceTrackingController.swift
//  RhythMage
//
//  Created by Marcos Vinicius Majeveski De Angeli on 25/10/21.
//

import ARKit
import UIKit

//MARK: - Delegate Protocol
protocol FaceTrackingControllerDelegate {
    
    /// The method to be called when a face was recognized as predominant
    /// - Parameter face: The face that was predominant
    func faceRecognized(face: ARFaceAnchor.BlendShapeLocation)
    
    /// The method to be called when a face was recognized as predominant and held by an amout of time
    /// - Parameter face: The face that was predominant
    func faceHeld(face: ARFaceAnchor.BlendShapeLocation, for time: Double)
    
    /// The method to be called when a face was being held and then was released.
    func faceReleased()
}

//MARK: - FaceTrackingController

/// The UIView to be called and setted when there is supposed to be face tracking of the user. The tracked faces must be setted and the parent must set itself to be one of the FaceTrackingControler's delegates
class FaceTrackingController: UIView {
    //MARK: Properties
    /// The view of the class used for tracking.
    var sceneView: ARSCNView?
    
    /// If the controller is or not enabled
    var isEnabled: Bool = true
    
    /// The face that ispredominant among the others and has it's factor above the setted factorValue.
    var predominantFace: ARFaceAnchor.BlendShapeLocation?
    
    /// The invterval between delegate updates when a face is beign held.
    var heldUpdateRate: Double = 0.01
    
    /// The time since the last update to the delegates regarding a face held.
    var timeSinceLastDelegateHeldUpdate: Double = 0
    
    /// The factor value that a face must have to trigger as predominant.
    var factorValue: Float = 0.5
    
    /// The value describing if the delegate is supposed to be called for every face change. If true might consume more of the processor.
    var updateForEveryFaceChange: Bool = false
    
    /// The array of delegates that must receive updates.
    var delegates = [FaceTrackingControllerDelegate]()
    
    var isViewHidden: Bool = false {
        didSet{
            guard let sceneView = sceneView else {return}
            sceneView.isHidden = isViewHidden
        }
    }
    
    //MARK: Private Properties
    /// The interval between updates of the timer
    private let timerResolution: Double = 0.001
    
    /// The faces setted to be tracked
    private var trackedFaces = [ARFaceAnchor.BlendShapeLocation]()
    
    /// The current  face hold time
     var heldTime: Double = 0
    
    /// The current timer that is on use or a nil value
    private var timer: Timer?
    
    //MARK: - Initialization
    init() {
        super.init(frame: CGRect(x: 0, y: 0, width: 100, height: 100))
        initialConfiguration()
        sceneView?.delegate = self
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - Configuration Methods
    func initialConfiguration() {
        guard ARFaceTrackingConfiguration.isSupported else { fatalError("iPhone X required") }
        let arScene = ARSCNView(frame: self.frame)
        let configuration = ARFaceTrackingConfiguration()
        
        configuration.isLightEstimationEnabled = true
        if #available(iOS 13.0, *) {
            configuration.maximumNumberOfTrackedFaces = ARFaceTrackingConfiguration.supportedNumberOfTrackedFaces
        }
        
        arScene.automaticallyUpdatesLighting = true
        arScene.session.run(configuration, options: [.resetTracking, .removeExistingAnchors])
        arScene.delegate = self
        arScene.isHidden = true
        sceneView = arScene
        guard sceneView != nil else {fatalError("Could not create a Face Tracking Controller")}
        addSubview(sceneView!)
    }
    
    //MARK: - Set Methods
    
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
    
    func kill() {
        timer = nil
        predominantFace = nil
        sceneView = nil
        updateForEveryFaceChange = false
        isEnabled = false
        trackedFaces = []
        delegates = []
        heldTime = 0
        timeSinceLastDelegateHeldUpdate = 0
        for subview in self.subviews {
            subview.removeFromSuperview()
        }
    }
}

//MARK: - ARSceneViewDelegate
extension FaceTrackingController: ARSCNViewDelegate {
    
    func renderer(_ renderer: SCNSceneRenderer, didUpdate node: SCNNode, for anchor: ARAnchor) {
        if isEnabled {
            guard let faceAnchor = anchor as? ARFaceAnchor else {return}
            
            var highestFactor: Float = 0
            var newPredominantFace: ARFaceAnchor.BlendShapeLocation?
            
            for face in trackedFaces {
                guard let faceFactor = faceAnchor.blendShapes[face] as? Float else {return}
                
                if face == predominantFace && faceFactor < factorValue && heldTime > 0 && timer != nil {
                    resetHeldTime()
                        for delegate in delegates {
                            delegate.faceReleased()
                        }
                    
                    return
                }
                
                if faceFactor > factorValue && faceFactor > highestFactor {
                    highestFactor = faceFactor
                    newPredominantFace = face
                }
            }
            
            if highestFactor < factorValue && timer != nil{
                resetHeldTime()
                return
            }
            
            guard let newPredominantFace = newPredominantFace else {return}
            if newPredominantFace != predominantFace {
                predominantFace = newPredominantFace
                resetHeldTime()
                triggerHeldTime()
                
                if updateForEveryFaceChange {
                    for delegate in delegates {
                        delegate.faceRecognized(face: newPredominantFace)
                    }
                }
            }
            
            if newPredominantFace == predominantFace && timer == nil {
                resetHeldTime()
                triggerHeldTime()
            }
        }
    }
    
    //MARK: - Timer Methods
    
    @objc private func timerUpdate() {
        if timer != nil {
            heldTime += timerResolution
            timeSinceLastDelegateHeldUpdate += timerResolution
            
            if timeSinceLastDelegateHeldUpdate >= heldUpdateRate && heldTime >= heldUpdateRate{
                guard let face = predominantFace else {return}
                timeSinceLastDelegateHeldUpdate = 0
                for delegate in delegates {
                    delegate.faceHeld(face: face, for: heldTime)
                }
            }
        }
    }
    
    private func triggerHeldTime() {
        timer = Timer.scheduledTimer(timeInterval: timerResolution, target: self, selector: #selector(timerUpdate), userInfo: nil, repeats: true)
    }
    
    private func resetHeldTime() {
        timer?.invalidate()
        timer = nil
        heldTime = 0
    }
    
    //    private func update(with faceAnchor: ARFaceAnchor) {
    //        var highestFactor: Float = 0
    //        var highestFace: ARFaceAnchor.BlendShapeLocation?  //MOCKADO
    //
    //        for face in trackedFaces {
    //            guard let faceFactor = faceAnchor.blendShapes[face] as? Float else {return}
    //            if faceFactor > highestFactor && faceFactor > factorValue{
    //                highestFactor = faceFactor
    //                highestFace = face
    //            }
    //
    //            if face == predominantFace && faceFactor < factorValue && timer != nil{ //Checking if the predominantFace was held
    //                heldTime = 0
    //                timer?.invalidate()
    //                timer = nil
    //                predominantFace = nil
    //            }
    //        }
    //
    //        //Resets the heldTime and Timer if the face has changed
    //        guard let highestFace = highestFace else {return}
    //        if predominantFace != highestFace {
    //            predominantFace = highestFace
    //            heldTime = 0
    //            timer?.invalidate()
    //            timer = Timer.scheduledTimer(timeInterval: timerResolution, target: self, selector: #selector(timerUpdate), userInfo: nil, repeats: true)
    //
    //            //Update every delegate for a face change if true
    //            if updateForEveryFaceChange {
    //                for delegate in delegates {
    //                    delegate.faceRecognized(face: highestFace)
    //                }
    //            }
    //        }
    //
    //        //Update every delegate for a new heldTime
    //        if heldTime >= heldUpdateRate {
    //            for delegate in delegates {
    //                delegate.faceHeld(face: highestFace, for: heldTime)
    //            }
    //        }
    //
    //
    //    }
}
