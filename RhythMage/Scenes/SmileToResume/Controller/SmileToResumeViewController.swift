//
//  SmileToResumeController.swift
//  RhythMage
//
//  Created by Juliana Prado on 20/10/21.
//

import UIKit
import ARKit

protocol SmileToResumeDelegate {
    func resumed()
}

class SmileToResumeViewController: BaseViewController<SmileToResumeView> {
    private let faceTrackingController: FaceTrackingController = FaceTrackingController()
    private let rootNavController: UINavigationController
    
    private var initiatedGameScene: Bool = false
    var delegate: SmileToResumeDelegate?
    
    /// Tells whether the face tracking is supported on a device(currently it's only for iPhone X).
    /// Please check before creating this view controller!
    static public var isSupported: Bool {
        return ARFaceTrackingConfiguration.isSupported
    }
    
    init (rootNavController: UINavigationController) {
        self.rootNavController = rootNavController
        super.init(mainView: SmileToResumeView())
        mainView.delegate = self
        
        //Face Tracking initialization
        mainView.addSubview(faceTrackingController)
        setupFaceTracking()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - ViewLifeCycle
    override func viewWillDisappear(_ animated: Bool) {
        faceTrackingController.kill()
    }
}

//MARK: - SmileToResumeDelegate
extension SmileToResumeViewController: SmileToResumeViewDelegate {
    
    @objc func onMainMenuButtonClicked() {
        faceTrackingController.kill()
        DispatchQueue.main.async {
            self.rootNavController.popToViewController(ofClass: SmileToUnlockController.self, animated: true)
        }
        self.dismiss(animated: true)
    }
    
}

//MARK: - FaceTrackingControllerDelegate
extension SmileToResumeViewController: FaceTrackingControllerDelegate {
    
    fileprivate func setupFaceTracking() {
        faceTrackingController.initialConfiguration()
        faceTrackingController.isEnabled = true
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
                self.dismiss(animated: true)
                self.delegate?.resumed()
            }
        }
    }
    
    func faceReleased() {
        DispatchQueue.main.async {
            self.mainView.progressView.setProgress(0, animated: true)
        }
    }
    
    
}
