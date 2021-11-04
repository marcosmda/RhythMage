//
//  GameDisplayView.swift
//  RhythMage
//
//  Created by Juliana Prado on 22/10/21.
//

import UIKit

class GameDisplayView: UIView {
    
    //MARK: - Properties
    public var song: SongContainerView
    var delegate: GameSceneDelegate?
    var level: Level?
    
    var hitBarImage: UIImageView = {
        let image = UIImageView()
        image.image = UIImage(named: "bar")
        image.contentMode = .scaleAspectFill
        return image
    }()
    
    ///progress bar
    lazy var progressView: UIProgressView = {
        let progressView = UIProgressView(progressViewStyle: .default)
        progressView.translatesAutoresizingMaskIntoConstraints = false
        progressView.trackTintColor = .clear
        progressView.progressTintColor = .white
        progressView.layer.cornerRadius = 8.4
        progressView.clipsToBounds = true
        progressView.layer.borderWidth = 1
        progressView.layer.borderColor = UIColor.white.cgColor
        return progressView
    }()
    
    ///container for the song view and progress bar
    fileprivate let container: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = UIColor.backgroundColor5.withAlphaComponent(0.3)
        view.clipsToBounds = true
        view.layer.cornerRadius = 20
        return view
    }()
    
    //  MARK: - Initializers
    
    convenience init(frame: CGRect, level: Level){
        
        self.init(frame: frame)
        self.level = level

        self.song.configure(with: level, userModel:   nil)
        setupHiararchy()
        setupLayout()
    }
    
    override init(frame: CGRect) {
        self.song = SongContainerView(type: .playingSong)
        super.init(frame: frame)
        self.song.translatesAutoresizingMaskIntoConstraints = false
        self.backgroundColor = .clear
        let tapGestureRecognizer = UITapGestureRecognizer(target:self, action: #selector  (togglePlayGame(_:)))
        self.song.iconImageView.isUserInteractionEnabled = true
        self.song.iconImageView.addGestureRecognizer(tapGestureRecognizer)
        self.frame = UIScreen.main.bounds  
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
        
    @objc func togglePlayGame(_ sender: UITapGestureRecognizer){
        delegate?.pauseGame()
    }
    
    //MARK: - Layout Subviews
    func setupLayout(){

        NSLayoutConstraint.activate([
            ///Constraints - container
            container.widthAnchor.constraint(equalTo: self.widthAnchor, multiplier: 0.9),
            container.heightAnchor.constraint(equalTo: self.heightAnchor, multiplier: 0.14),
            container.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            //container.trailingAnchor.constraint(equalTo: self.layoutMarginsGuide.trailingAnchor),
            //container.leadingAnchor.constraint(equalTo: self.layoutMarginsGuide.leadingAnchor),
            
            ///Constraints - song view
            song.heightAnchor.constraint(equalTo: container.heightAnchor, multiplier: 0.78),
            song.leadingAnchor.constraint(equalTo: container.leadingAnchor),
            song.trailingAnchor.constraint(equalTo: container.trailingAnchor),
            song.topAnchor.constraint(equalTo: container.topAnchor),
            
            ///Constraints - progress view
            progressView.widthAnchor.constraint(equalTo: container.widthAnchor, multiplier: 0.9),
            progressView.heightAnchor.constraint(equalTo: container.heightAnchor, multiplier: 0.13),
            progressView.bottomAnchor.constraint(equalTo: container.bottomAnchor, constant: -10),
            progressView.centerXAnchor.constraint(equalTo: container.centerXAnchor),
        ])
    }
    
    
    override func layoutSubviews() {
        super.layoutSubviews()
        let window = self.window?.windowScene?.keyWindow
        let topPadding = window?.safeAreaInsets.top
        
        container.topAnchor.constraint(equalTo: self.topAnchor, constant:  topPadding!).isActive = true
        //  previewCameraLayer.topAnchor.constraint(equalTo: self.topAnchor, constant: topPadding!).isActive = true
        
        //  delegate?.updateCamera(cameraView: previewCameraLayer) //TODO: estranho
    }
    
    
    //MARK: - Hierarchy
    func setupHiararchy(){
        self.addSubview(container)
        container.addSubview(progressView)
        container.addSubview(song)
        self.addSubview(hitBarImage)
    }
    
}
