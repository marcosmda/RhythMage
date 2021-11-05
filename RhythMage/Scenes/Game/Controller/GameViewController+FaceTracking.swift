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
        faceTrackingController.frame = UIScreen.main.bounds
        faceTrackingController.initialConfiguration()
        faceTrackingController.isEnabled = true
        faceTrackingController.delegates.append(self)
        faceTrackingController.addTrackedFaces(faces: [.mouthLeft, .jawOpen, .mouthRight])
        faceTrackingController.heldUpdateRate = 0.1
    }
    
    func viewWillAppearFaceTracking(){
        faceTrackingController.isViewHidden = false
    }
    
    //MARK: - Protocol Methods
    func faceRecognized(face: ARFaceAnchor.BlendShapeLocation) {
        switch face {
        case .mouthRight: //Sim, é invertido
            mainScene.leftFaceExpression.updateExpressionActiveAnimation(with: true)
            for tile in mainScene.tilesInContact {
                if (tile.value.tileInteraction.xPosition == ScreenScrollArea.left.rawValue) {
                    let tileOrb = tile.value
                    mainScene.tilesInContact.removeValue(forKey: tile.key)
                    mainScene.updateScore(by: tile.value.tileInteraction.minimumScore)
                    mainScene.leftFaceExpression.runHitAnimation()
                    tileOrb.runHitAnimation()
                }
            }
        case .jawOpen:
            mainScene.middleFaceExpression.updateExpressionActiveAnimation(with: true)
            for tile in mainScene.tilesInContact {
                if (tile.value.tileInteraction.xPosition == ScreenScrollArea.middle.rawValue) {
                    let tileOrb = tile.value
                    mainScene.tilesInContact.removeValue(forKey: tile.key)
                    mainScene.updateScore(by: tile.value.tileInteraction.minimumScore)
                    mainScene.middleFaceExpression.runHitAnimation()
                    tileOrb.runHitAnimation()
                }
            }
        case .mouthLeft: //Sim, é invertido
            mainScene.rightFaceExpression.updateExpressionActiveAnimation(with: true)
            for tile in mainScene.tilesInContact {
                if (tile.value.tileInteraction.xPosition == ScreenScrollArea.right.rawValue) {
                    let tileOrb = tile.value
                    mainScene.tilesInContact.removeValue(forKey: tile.key)
                    mainScene.updateScore(by: tile.value.tileInteraction.minimumScore)
                    mainScene.rightFaceExpression.runHitAnimation()
                    tileOrb.runHitAnimation()
                }
            }
        default:
            return
        }
    }
    
    func faceHeld(face: ARFaceAnchor.BlendShapeLocation, for time: Double) {
        switch face {
        case .mouthRight: //Sim, é invertido
            for tile in mainScene.tilesInContact {
                if (tile.value.tileInteraction.xPosition == ScreenScrollArea.left.rawValue) {
                    let tileOrb = tile.value
                    mainScene.tilesInContact.removeValue(forKey: tile.key)
                    mainScene.updateScore(by: tile.value.tileInteraction.minimumScore)
                    mainScene.leftFaceExpression.runHitAnimation()
                    tileOrb.runHitAnimation()
                }
            }
        case .jawOpen:
            for tile in mainScene.tilesInContact {
                if (tile.value.tileInteraction.xPosition == ScreenScrollArea.middle.rawValue) {
                    let tileOrb = tile.value
                    mainScene.tilesInContact.removeValue(forKey: tile.key)
                    mainScene.updateScore(by: tile.value.tileInteraction.minimumScore)
                    mainScene.middleFaceExpression.runHitAnimation()
                    tileOrb.runHitAnimation()
                }
            }
        case .mouthLeft: //Sim, é invertido
            for tile in mainScene.tilesInContact {
                if (tile.value.tileInteraction.xPosition == ScreenScrollArea.right.rawValue) {
                    let tileOrb = tile.value
                    mainScene.tilesInContact.removeValue(forKey: tile.key)
                    mainScene.updateScore(by: tile.value.tileInteraction.minimumScore)
                    mainScene.rightFaceExpression.runHitAnimation()
                    tileOrb.runHitAnimation()
                }
            }
        default:
            return
        }
        
    }
    
    func faceReleased() {
        for expression in mainScene.facialExpressions {
            if expression.isCircleActive {
                expression.updateExpressionActiveAnimation()
            }
        }
    }
}
