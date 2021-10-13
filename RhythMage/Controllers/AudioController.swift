//
//  AudioPlayer.swift
//  RhythMage
//
//  Created by Marcos Vinicius Majeveski De Angeli on 13/10/21.
//

import AVFoundation

class AudioController {
    
    var player: AVAudioPlayer?
    var urlString: String?
    
    init() {
        setupSession()
    }
    
    //MARK: - Methods
    func setupSession() {
        let audioSession = AVAudioSession.sharedInstance()
        do {
            try audioSession.setCategory(.playback, mode: .default)
            try audioSession.setActive(true, options: .notifyOthersOnDeactivation)
        } catch {
            //TODO: Manage Error
        }
    }
    
    func prepareToPlay() {
        if let urlString = urlString {
            do {
                player = try AVAudioPlayer(contentsOf: URL(fileURLWithPath: urlString))
            } catch {
                //TODO: Manage Error
            }
        }
    }
    
    //MARK: - Public Methods
    public func updateUrl(fileName: String, fileType: String) {
        urlString = Bundle.main.path(forResource: fileName, ofType: fileType)
        prepareToPlay()
    }
    
    public func play() {
        player?.play()
    }
    
    public func pause() {
        player?.pause()
    }
}
