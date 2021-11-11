//
//  GameViewController+AudioController.swift
//  RhythMage
//
//  Created by Marcos Vinicius Majeveski De Angeli on 29/10/21.
//

import Foundation

extension GameViewController: AudioControllerDelegate {
    
    func initAudioController() {
        
        self.audioController.delegates.append(self)
        setupAudioController()
    }
    
    func setupAudioController() {
        audioController.updateUrl(fileName: "Puffs", fileType: "mp3")
        audioController.start(playing: false)
    }
    
    func audioFinished() {
        DispatchQueue.main.async {
            self.navigationController?.pushViewController(self.factory.createSummaryScene(score: Int(self.mainScene.score), level: self.level, images: self.images), animated: true)
        }
    }
    
    @objc func startAudio() {
        audioController.play()
    }
}
