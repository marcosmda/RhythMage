//
//  GameViewController+SmileToResume.swift
//  RhythMage
//
//  Created by Marcos Vinicius Majeveski De Angeli on 29/10/21.
//

import Foundation

extension GameViewController: SmileToResumeDelegate {
    func resumed() {
        audioController.start(playing: false)
        toggleGameStatus()
    }
}
