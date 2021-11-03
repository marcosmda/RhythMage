//
//  GameViewController+FaceTracking.swift
//  RhythMage
//
//  Created by Marcos Vinicius Majeveski De Angeli on 29/10/21.
//

import UIKit
import ARKit

extension GameViewController: FaceTrackingControllerDelegate {
    
    func initFaceTracking() {
        mainView.addSubview(faceTrackingController)
        faceTrackingController.initialConfiguration()
        faceTrackingController.isEnabled = true
        faceTrackingController.delegates.append(self)
        faceTrackingController.addTrackedFaces(faces: [.mouthLeft, .jawOpen, .mouthRight])
    }
    
    func viewWillAppearFaceTracking(){
        faceTrackingController.isViewHidden = false
    }
    
    //MARK: - Protocol Methods
    func faceRecognized(face: ARFaceAnchor.BlendShapeLocation) {
        switch face {
        case .mouthRight: //Sim, é invertido
            for tile in mainScene.tilesInContact {
                if (tile.value.tileInteraction.xPosition == ScreenScrollArea.left.rawValue) {
                    mainScene.updateScore(by: tile.value.tileInteraction.minimumScore)
                }
            }
        case .jawOpen:
            for tile in mainScene.tilesInContact {
                if (tile.value.tileInteraction.xPosition == ScreenScrollArea.middle.rawValue) {
                    mainScene.updateScore(by: tile.value.tileInteraction.minimumScore)
                }
            }
        case .mouthLeft: //Sim, é invertido
            for tile in mainScene.tilesInContact {
                if (tile.value.tileInteraction.xPosition == ScreenScrollArea.right.rawValue) {
                    mainScene.updateScore(by: tile.value.tileInteraction.minimumScore)
                }
            }
        default:
            return
        }
    }
    
    func faceHeld(face: ARFaceAnchor.BlendShapeLocation, for time: Double) {}
    
    func faceReleased() {}
}
