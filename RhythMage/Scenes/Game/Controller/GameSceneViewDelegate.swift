//
//  GameSceneViewDelegate.swift
//  RhythMage
//
//  Created by Juliana Prado on 22/10/21.
//

import Foundation
import UIKit

protocol GameSceneDelegate {
    func getElapsedTime() -> Double
    func pauseGame()
    func updateCamera(cameraView: UIView)
}
