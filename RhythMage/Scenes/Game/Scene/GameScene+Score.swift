//
//  GameScene+Score.swift
//  RhythMage
//
//  Created by Marcos Vinicius Majeveski De Angeli on 03/11/21.
//

import Foundation

extension GameScene {
    func updateScore(by points: Double) {
        score += points
        DispatchQueue.main.async {
            self.gameDelegate?.updatedScore(score: self.score.rounded())
        }
    }
    
    func resetScore() {
        score = 0
        DispatchQueue.main.async {
            self.gameDelegate?.updatedScore(score: self.score.rounded())
        }
    }
}
