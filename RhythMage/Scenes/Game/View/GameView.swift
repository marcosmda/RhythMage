//
//  GameView.swift
//  RhythMage
//
//  Created by Bruna Costa on 29/10/21.
//

import Foundation
import UIKit
import SpriteKit

class GameView: SKView {
    
    let faceTrackingView: FaceTrackingController
    let displayView: GameDisplayView
    let cameraView: GameCameraDisplayView
    
    init(frame: CGRect, faceTrackingView: FaceTrackingController){
        self.faceTrackingView = faceTrackingView
        self.cameraView = GameCameraDisplayView(faceTrackingView: self.faceTrackingView)
        self.displayView = GameDisplayView()
        
        super.init(frame: frame)
        
        self.addSubview(displayView)
        self.addSubview(cameraView)
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
