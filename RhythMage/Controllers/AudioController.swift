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
    private var timer: Timer?
    private var started: Bool
    private let timerResolution: Double
    
    var delegates: [AudioControllerDelegate]
    var urlString: String?
    var isPlaying: Bool
    var elapsedTime: Double {
        guard let player = player else {return 0}
        return player.currentTime
    }
    
    init() {
        self.started = false
        self.timerResolution = 0.01
        
        self.delegates = [AudioControllerDelegate]()
        self.isPlaying = false
        setupSession()
    }
    
    //MARK: - Public Methods
    public func updateUrl(fileName: String, fileType: String) {
        urlString = Bundle.main.path(forResource: fileName, ofType: fileType)
        prepareToPlay()
    }
    
    public func start() {
        started = true
        play()
        setTimer()
    }
    
    public func play() {
        if started {
            isPlaying = true
            player?.play()
            setTimer()
        } else {
            dump("Player Not Started")
        }
    }
    
    public func pause() {
        isPlaying = false
        player?.pause()
        timer?.invalidate()
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
    
    private func setTimer() {
        timer = Timer.scheduledTimer(timeInterval: timerResolution, target: self, selector: #selector(updateElapsedTime), userInfo: nil, repeats: true)
    }
    
    @objc private func updateElapsedTime() {
        if let player = player, player.currentTime == 0 && started{
            timer?.invalidate()
            started = false
            isPlaying = false
            for delegate in delegates {
                delegate.audioFinished()
            }
        }
    }
    
    
    
    
}
