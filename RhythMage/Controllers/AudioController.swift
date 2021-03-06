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

class AudioController: NSObject {
    
    private var player: AVAudioPlayer?
    private var started: Bool
    
    var delegates: [AudioControllerDelegate]
    var urlString: String?
    
    override init() {
        self.started = false
        self.delegates = [AudioControllerDelegate]()
        super.init()
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
        if player?.isPlaying ?? true {return}
        
        if started {
            player?.play()
        } else {
            dump("Player Not Started")
        }
    }
    
    public func pause() {
        if !(player?.isPlaying ?? false) {return}
        
        if started {
            player?.pause()
        } else {
            dump("Player Not Started")
        }
    }
    
    public func toggle() {
        if player?.isPlaying ?? true {
            pause()
        } else {
            play()
        }
    }
    
    //Sets the volume of the player. 0.1 is very low and 1 is maximum volume
    public func playerVolume(myVolume: Float){
        player?.volume = myVolume
        
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
                player?.delegate = self
                player?.volume = 0.7
            } catch {
                //TODO: Manage Error
            }
        }
    }
    
    public func getPlayerTime() -> Double? {
        return player?.currentTime
    }
    
    public func getAudioDuration() -> Double? {
        return player?.duration
    }
    
}

extension AudioController: AVAudioPlayerDelegate {
    
    func audioPlayerDidFinishPlaying(_ player: AVAudioPlayer, successfully flag: Bool) {
        started = false
        for delegate in delegates {
            delegate.audioFinished()
        }
    }
}

//MARK: - AVPlayer Extensions
extension AVPlayer {
    func stop(){
        self.seek(to: CMTime.zero)
        self.pause()
    }
}
