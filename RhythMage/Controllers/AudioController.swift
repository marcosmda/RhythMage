//
//  AudioPlayer.swift
//  RhythMage
//
//  Created by Marcos Vinicius Majeveski De Angeli on 13/10/21.
//

import AVFoundation

protocol AudioControllerDelegate {
    func audioFinished()
}

class AudioController {
    
    private var player: AVAudioPlayer?
    private var started: Bool
    
    var delegates: [AudioControllerDelegate]
    var urlString: String?
    var isPlaying: Bool
    
    init() {
        self.started = false
        
        self.delegates = [AudioControllerDelegate]()
        self.isPlaying = false
        setupSession()
    }
    
    //MARK: - Public Methods
    public func updateUrl(fileName: String, fileType: String) {
        urlString = Bundle.main.path(forResource: fileName, ofType: fileType)
        prepareToPlay()
    }
    
    public func start(playing: Bool) {
        started = true
        if playing {
            play()
        }
    }
    
    public func play() {
        if isPlaying {return}
        
        if started {
            isPlaying = true
            player?.play()
        } else {
            dump("Player Not Started")
        }
    }
    
    public func pause() {
        if !isPlaying {return}
        
        if started {
            isPlaying = false
            player?.pause()
        } else {
            dump("Player Not Started")
        }
    }
    
    public func toggle() {
        if isPlaying {
            pause()
        } else {
            play()
        }
    }
    
    //MARK: - Private Methods
    private func setupSession() {
        let audioSession = AVAudioSession.sharedInstance()
        do {
            try audioSession.setCategory(.playback, mode: .default)
            try audioSession.setActive(true, options: .notifyOthersOnDeactivation)
        } catch {
            //TODO: Manage Error
        }
    }
    
    private func prepareToPlay() {
        if let urlString = urlString {
            do {
                player = try AVAudioPlayer(contentsOf: URL(fileURLWithPath: urlString))
            } catch {
                //TODO: Manage Error
            }
        }
    }
    
    @objc private func updateElapsedTime() {
        if let player = player, isPlaying && !player.isPlaying{
            started = false
            isPlaying = false
            for delegate in delegates {
                delegate.audioFinished()
            }
        }
    }
    
    
    
    
}
