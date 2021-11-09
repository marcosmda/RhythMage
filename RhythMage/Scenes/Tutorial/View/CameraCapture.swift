//
//  CameraCapture.swift
//  RhythMage
//
//  Created by Lucas Frazão on 27/10/21.
//

import UIKit

class CameraCapture: UIView {
    
    private var isSoundOn: Bool = true
    private var gradientView = GradientBackgroundView()
    var delegate: CameraCaptureDelegate?
    
    var previewCameraLayer: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.clipsToBounds = true
        view.setContentHuggingPriority(.defaultLow, for: .vertical)
        view.setContentCompressionResistancePriority(.defaultLow, for: .vertical)
        return view
    }()
    
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
        label.text = "There you are! Wizard Assistent, you were hired to help pick up the spells and store them in the Ancestral Book."
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
        delegate?.checkIfSoundAvailable(sender)
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubview(gradientView)
        addSubview(previewCameraLayer)
        addSubview(backgroundSubtitleView)
        drawBlurBackground()
        addSubview(soundOption)
        backgroundSubtitleView.addSubview(subtitle)
        setupLayout()
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
        
    }
    
    func setupLayout() {
        
        //MARK: - Gradient
        gradientView.setupCircleBackgroundBlur()
        
        gradientView.translatesAutoresizingMaskIntoConstraints = false
        gradientView.topAnchor.constraint(equalTo: self.topAnchor).isActive = true
        gradientView.leadingAnchor.constraint(equalTo: self.leadingAnchor).isActive = true
        gradientView.trailingAnchor.constraint(equalTo: self.trailingAnchor).isActive = true
        gradientView.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive = true
        
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
        
        previewCameraLayer.widthAnchor.constraint(equalTo: self.widthAnchor).isActive = true
        previewCameraLayer.heightAnchor.constraint(equalTo: self.heightAnchor).isActive = true
        previewCameraLayer.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
        previewCameraLayer.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true
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
