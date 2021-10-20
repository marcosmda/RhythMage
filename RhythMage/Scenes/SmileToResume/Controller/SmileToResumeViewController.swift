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
    
    typealias Factory = SmileToResumeFactory
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
        
//        configureFaceRecognition()
        ableToPlay = true
        
        let bool = true
        if bool {
//            self.navigationItem.leftBarButtonItem = self.mainView.buttonSettings
        }
    }
    
    func onMainMenuButtonClicked() {
        
    }
    
}

//MARK: - ARSCNViewDelegate
extension SmileToResumeViewController: ARSCNViewDelegate {
    
}

extension SmileToResumeViewController: SmileToResumeDelegate {
    
}
