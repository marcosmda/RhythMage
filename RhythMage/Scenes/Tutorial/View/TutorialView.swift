//
//  TutorialView.swift
//  RhythMage
//
//  Created by Lucas Frazão on 25/10/21.
//

import UIKit
import AVKit
import AVFoundation

protocol TutorialViewDelegate {
    func updateSubtitles(currentTime: Double)
    func didEndVideo()
}

class TutorialView: UIView {

    private var timer: Timer?
    private var video: Video?
    private var isSoundOn: Bool = true
    private var player: AVPlayer?
    private var timeElapsed: Double = 0.0
    
    var videoDelegate: TutorialViewDelegate?
    
    private let backgroundSubtitleView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .terciary.withAlphaComponent(0.5)
        view.layer.cornerRadius = 20
        view.clipsToBounds = true
        return view
    }()
    
   lazy var subtitle: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .inikaBold(ofSize: 18)
        label.numberOfLines = 0
        label.textColor = .white
        return label
    }()
    
    lazy var soundOption: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.backgroundColor = .terciary.withAlphaComponent(0.5)
        button.setImage(UIImage(systemName: "speaker.wave.3.fill"), for: .normal)
        button.tintColor = .white
        button.layer.cornerRadius = 20
        button.addTarget(self, action: #selector(onSoundOption), for: .touchUpInside)
        button.clipsToBounds = true
        return button
    }()
    
    @objc func onSoundOption(_ sender: UIButton) {
        isSoundOn.toggle()
        
        switch self.isSoundOn {
            case true:
                player?.volume = 1.0
                UIView.transition(with: sender, duration: 0.3, options: .transitionCrossDissolve) {
                    self.soundOption.setImage(UIImage(systemName: "speaker.wave.3.fill"), for: .normal)
                }

            case false:
                player?.volume = 0.0
                UIView.transition(with: sender, duration: 0.3, options: .transitionCrossDissolve) {
                self.soundOption.setImage(UIImage(systemName: "speaker.slash.fill"), for: .normal)
            }
            
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubview(backgroundSubtitleView)
        drawBlurBackground()
        addSubview(soundOption)
        backgroundSubtitleView.addSubview(subtitle)
        setupLayout()
        
    }
    
    convenience init(video: Video) {
        self.init(frame: .zero)
        self.video = video
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
        
    }
    
    func setupLayout() {
        
        //MARK: - SoundOption
        soundOption.topAnchor.constraint(equalTo: self.topAnchor, constant: 40).isActive = true
        soundOption.trailingAnchor.constraint(equalTo: self.layoutMarginsGuide.trailingAnchor).isActive = true
        soundOption.widthAnchor.constraint(equalTo: self.widthAnchor, multiplier: 0.1).isActive = true
        soundOption.heightAnchor.constraint(equalTo: soundOption.widthAnchor).isActive = true
        
        //MARK: - Background Subtitle
        backgroundSubtitleView.bottomAnchor.constraint(equalTo: self.layoutMarginsGuide.bottomAnchor).isActive = true
        backgroundSubtitleView.widthAnchor.constraint(equalTo: self.widthAnchor, multiplier: 0.9).isActive = true
        backgroundSubtitleView.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
        
        //MARK: - Subtitle
        subtitle.topAnchor.constraint(equalTo: backgroundSubtitleView.topAnchor, constant: 20).isActive = true
        subtitle.centerXAnchor.constraint(equalTo: backgroundSubtitleView.centerXAnchor).isActive = true
        subtitle.centerYAnchor.constraint(equalTo: backgroundSubtitleView.centerYAnchor).isActive = true
        subtitle.widthAnchor.constraint(equalTo: backgroundSubtitleView.widthAnchor, multiplier: 0.9).isActive = true
        subtitle.bottomAnchor.constraint(equalTo: backgroundSubtitleView.bottomAnchor, constant: -20).isActive = true
        
    }
    
    func drawBlurBackground() {
        let blurEffect = UIBlurEffect(style: .systemUltraThinMaterialDark)
        let blurEffectView = UIVisualEffectView(effect: blurEffect)
        blurEffectView.frame = self.bounds
        blurEffectView.alpha = 0.95
        blurEffectView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        backgroundSubtitleView.addSubview(blurEffectView)
    }
    
}

extension TutorialView {
    
    func playVideo(with name: String) {
        guard let path = Bundle.main.path(forResource: name, ofType:"mp4") else {
            debugPrint("rhythMage.m4v not found")
            return
        }
        
        player = AVPlayer(url: URL(fileURLWithPath: path))
        let playerLayer = AVPlayerLayer(player: player)
        self.layer.insertSublayer(playerLayer, at: 0)
        playerLayer.frame = self.layer.bounds
        playerLayer.videoGravity = .resizeAspectFill
        player?.play()
        setTimer()
        
        NotificationCenter.default.addObserver(self, selector: #selector(playerDidFinishPlaying),
                                               name: NSNotification.Name.AVPlayerItemDidPlayToEndTime, object: player?.currentItem)
        
    }
    
    @objc func playerDidFinishPlaying(note: NSNotification) {
        videoDelegate?.didEndVideo()
    }
    
    private func setTimer() {
        timer = Timer.scheduledTimer(timeInterval: 0.01, target: self, selector: #selector(updateElapsedTime), userInfo: nil, repeats: true)
    }
    
    @objc func updateElapsedTime() {
        timeElapsed = (player?.currentTime().seconds)!
        videoDelegate?.updateSubtitles(currentTime: timeElapsed)
    }
    
}
