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
    
    private let rootNavigationController: UINavigationController
    private let faceTrackingController = FaceTrackingController()
    
    private var initiatedGameScene: Bool = false
    
    typealias Factory = SmileToUnlockFactory
    let factory: Factory
    
    var delegate: SmileToResumeDelegate?
    
    /// Tells whether the face tracking is supported on a device(currently it's only for iPhone X).
    /// Please check before creating this view controller!
    static public var isSupported: Bool {
        return ARFaceTrackingConfiguration.isSupported
    }
    
    init (factory: Factory, rootNavigationController: UINavigationController) {
        self.factory = factory
        self.rootNavigationController = rootNavigationController
        super.init(mainView: SmileToResumeView())
        mainView.delegate = self
        
        //Face Tracking initialization
        mainView.addSubview(faceTrackingController)
        faceTrackingController.initialConfiguration()
        faceTrackingController.isEnabled = true
        faceTrackingController.delegates.append(self)
        faceTrackingController.addTrackedFaces(faces: [.mouthSmileLeft])
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
    
//    self.navigationController?.popViewController(animated: true)
//    self.dismiss(animated: true, completion: nil)
//    self.navigationController?.pushViewController(self.factory.createSmileToUnlockScene(), animated: true)
}

//MARK: - SmileToResumeDelegate
extension SmileToResumeViewController: SmileToResumeViewDelegate {
    
    @objc func onMainMenuButtonClicked() {
        dismiss(animated: true) {
            self.rootNavigationController.popToViewController(ofClass: SmileToUnlockController.self, animated: true)
            
            //self.rootNavigationController.popToRootViewController(animated: true)
            
        }
        
    }
    
}

extension SmileToResumeViewController: FaceTrackingControllerDelegate {
    func faceRecognized(face: ARFaceAnchor.BlendShapeLocation) {}
    
    func faceHeld(face: ARFaceAnchor.BlendShapeLocation, for time: Double) {
        DispatchQueue.main.async {
                self.mainView.progressView.setProgress(Float(time/2), animated: true)
        }
        if !initiatedGameScene && time >= 2 {
            initiatedGameScene = true
            self.delegate?.resumed()
            DispatchQueue.main.async {
                self.dismiss(animated: true, completion: nil)
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
