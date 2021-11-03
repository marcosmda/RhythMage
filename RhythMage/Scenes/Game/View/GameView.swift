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
    
    init(frame: CGRect, faceTrackingView: FaceTrackingController){
        self.faceTrackingView = faceTrackingView
        
        super.init(frame: frame)
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
