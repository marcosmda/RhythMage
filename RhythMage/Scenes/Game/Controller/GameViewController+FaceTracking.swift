//
//  GameViewController+FaceTracking.swift
//  RhythMage
//
//  Created by Marcos Vinicius Majeveski De Angeli on 29/10/21.
//

import UIKit
import RealmSwift

extension GameViewController {
    
    func initFaceTracking() {
        mainView.addSubview(faceTrackingController)
    }
    
}
