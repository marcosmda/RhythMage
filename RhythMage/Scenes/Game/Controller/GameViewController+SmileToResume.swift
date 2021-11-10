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
    
    func toggleGameStatus() {
        if !mainScene.isPaused {
            mainScene.isPaused = true
            audioController.pause()
            if timer != nil {
                remainingTime = timer?.fireDate.timeIntervalSince(Date()) ?? 3
                timer?.invalidate()
                timer = nil
            }
            
        } else if mainScene.isPaused {
            configFaceTracking()
            if timer == nil {
                timer = Timer.scheduledTimer(timeInterval: remainingTime, target: self, selector: #selector(startAudio), userInfo: nil, repeats: false)
                mainScene.isPaused = false
            } else {
                mainScene.isPaused = false
                audioController.play()
            }
        }
    }
}
