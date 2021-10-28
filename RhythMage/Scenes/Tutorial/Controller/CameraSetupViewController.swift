//
//  CameraSetupViewController.swift
//  RhythMage
//
//  Created by Lucas Frazão on 26/10/21.
//

import UIKit

class CameraSetupViewController: BaseViewController<CameraAccessView> {
    
    typealias Factory = CameraCaptureSceneFactory
    let factory: Factory
    
    init(factory: Factory) {
        self.factory = factory
        let view = CameraAccessView()
        super.init(mainView: view)
        mainView.delegate = self
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
}

extension CameraSetupViewController: CameraAccessDelegate {
    
    func didAuthorizeCameraAccess() {
        let transition = CATransition()
        transition.duration = 0.5
        transition.timingFunction = CAMediaTimingFunction(name: CAMediaTimingFunctionName.easeInEaseOut)
        transition.type = CATransitionType.fade
        DispatchQueue.main.async {
            self.navigationController?.view.layer.add(transition, forKey: nil)
            self.navigationController?.pushViewController(self.factory.createCameraCaptureScene(), animated: false)
        }
    }
    
}
