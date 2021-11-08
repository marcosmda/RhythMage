//
//  GameViewController+Capture.swift
//  RhythMage
//
//  Created by Marcos Vinicius Majeveski De Angeli on 04/11/21.
//

import UIKit

extension GameViewController {
    
    func viewWillAppearCapture() {
        Timer.scheduledTimer(timeInterval: (audioController.getAudioDuration() ?? 60)/4, target: self, selector: #selector(takeScreenshot), userInfo: nil, repeats: true)
    }
    
    @objc func takeScreenshot() {
        if counter > 0 {
            images.append(faceTrackingController.sceneView?.snapshot() ?? UIImage())
            counter -= 1
        }
    }
}
