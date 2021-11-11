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
    
    func viewWillAppearAudioController() {
        setupAudioController()
    }
    
    func setupAudioController() {
        audioController.updateUrl(fileName: level.songName, fileType: "m4a")
        audioController.start(playing: false)
    }
    
    func audioFinished() {
            self.navigationController?.pushViewController(self.factory.createSummaryScene(score: Int(self.mainScene.score), level: self.level, images: self.images), animated: true)
        
    }
    
    @objc func startAudio() {
        audioController.play()
    }
}
