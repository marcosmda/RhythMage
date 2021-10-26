//
//  TutorialView.swift
//  RhythMage
//
//  Created by Lucas Frazão on 25/10/21.
//

import UIKit
import AVKit
import AVFoundation

class TutorialView: UIView {

    private let backgroundSubtitleView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .terciary.withAlphaComponent(0.5)
        view.layer.cornerRadius = 20
        return view
    }()
    
    var subtitle: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "At the top of the icy mountains, there is a very clumsy mage, who always works his magic to different music."
        label.font = .inikaBold(ofSize: 18)
        label.numberOfLines = 4
        label.textColor = .white
        return label
    }()
    
    lazy var soundOption: UIButton = {
        let button = UIButton(frame: CGRect(x: 0, y: 0, width: 60, height: 60))
        button.translatesAutoresizingMaskIntoConstraints = false
        button.backgroundColor = .terciary.withAlphaComponent(0.5)
        button.setImage(UIImage(systemName: "speaker.wave.3.fill"), for: .normal)
        button.tintColor = .white
        button.layer.cornerRadius = 20
        //button.addTarget(self, action: #selector(onSettingsButtonPush), for: .touchUpInside)
        button.clipsToBounds = true
        return button
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubview(backgroundSubtitleView)
        addSubview(soundOption)
        backgroundSubtitleView.addSubview(subtitle)
        setupLayout()
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
    
}

extension TutorialView {
    
    func playVideo() {
        guard let path = Bundle.main.path(forResource: "rhythMage", ofType:"mp4") else {
            debugPrint("rhythMage.m4v not found")
            return
        }
        let player = AVPlayer(url: URL(fileURLWithPath: path))
        let playerLayer = AVPlayerLayer(player: player)
        self.layer.insertSublayer(playerLayer, at: 0)
        playerLayer.frame = self.layer.bounds
        playerLayer.videoGravity = AVLayerVideoGravity.resize
        player.volume = 1.0
        player.play()
        
        //MARK: - Could be used in the future
//        let playerController = AVPlayerViewController()
//        playerController.player = player
//        playerController.showsPlaybackControls = false
//        playerController.allowsPictureInPicturePlayback = true
//        playerController.player?.volume = 0.0
//        present(playerController, animated: true) {
//            player.play()
//        }
        
    }
    
}
