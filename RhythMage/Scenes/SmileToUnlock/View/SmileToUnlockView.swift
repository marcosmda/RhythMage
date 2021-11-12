//
//  SmileToUnlockView.swift
//  RhythMage
//
//  Created by Bruna Costa on 09/10/21.
//

import UIKit
import Foundation
import AVFoundation
import GameplayKit

protocol SmileToUnlockDelegate {
    func onSongLibraryButtonPush()
    func onLeaderboardButtonPush()
    func onSettingsButtonPush()
    func updateProgressBar()
}

class SmileToUnlockView: UIView {
    
    var tutorialInstruction = TutorialInstructionView()
    var songPlaying:String?
    var bestScore: String?
    var faceTrackingView: FaceTrackingController
    public var buttonSelected: Bool = false
    
    var gradientView = GradientBackgroundView()
    
    var delegate: SmileToUnlockDelegate?
    
    init(faceTrackingView: FaceTrackingController) {
        self.faceTrackingView = faceTrackingView
        super.init(frame: .zero)
        buttonSettings.tintColor = .label
        self.addSubview(gradientView)
        self.addSubview(nameGameTitle)
        self.addSubview(nameSongTitle)
        self.addSubview(bestScoreTitle)
//        previewCameraLayer.addSubview(faceTrackingView)
        self.addSubview(previewCameraLayer)
        self.addSubview(progressView)
        progressView.addSubview(smileToPlayTitle)
        self.addSubview(buttonSongLibrary)
        self.addSubview(tutorialInstruction)
        gradientView.setupCircleBackgroundBlur()
        setupLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    //Setting the image of the game
    let nameGameTitle: UIImageView = {
        let imageView = UIImageView(frame: .zero)
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.clipsToBounds = true
        imageView.image = UIImage(named: "Logo")
        imageView.contentMode = .scaleAspectFit
        imageView.setContentCompressionResistancePriority(.defaultHigh, for: .vertical)
        return imageView
    }()
    
    ///user camera view
    var previewCameraLayer: UIView = {
        let view = UIView()
        return view
    }()
    
    lazy var nameSongTitle: UILabel = {
        let label2 = UILabel(frame: .zero)
        label2.setContentHuggingPriority(.defaultHigh, for: .vertical)
        label2.translatesAutoresizingMaskIntoConstraints = false
        label2.textColor = .white
        label2.text = (songPlaying ?? "Now Playing: Fairytale Waltz from maestro-misha2012.")
        label2.numberOfLines = 0
        label2.textAlignment = .center
        label2.font = .inikaBold(ofSize: 18)
        label2.contentMode = .scaleAspectFit
        return label2
        
    }()
    
    lazy var bestScoreTitle: UILabel = {
        let label3 = UILabel(frame: .zero)
        label3.setContentHuggingPriority(.defaultHigh, for: .vertical)
        label3.translatesAutoresizingMaskIntoConstraints = false
        label3.textColor = .white
        label3.text = "Best Score: " + (bestScore ?? "0")
        label3.numberOfLines = 0
        label3.textAlignment = .center
        label3.font = .inika(ofSize: 18)
        label3.contentMode = .scaleAspectFill
        label3.minimumScaleFactor = 0.1
        label3.sizeToFit()
        label3.fitTextToBounds()
        return label3
        
    }()
    
    let smileToPlayTitle: UILabel = {
        let label4 = UILabel(frame: .zero)
        let attachment = NSTextAttachment()
        attachment.image = UIImage(systemName: "face.smiling.fill")?.withTintColor(.white)
        let imageOffsetY: CGFloat = -2.0
        attachment.bounds = CGRect(x: 0, y: imageOffsetY, width: attachment.image!.size.width, height: attachment.image!.size.height)
        let attachmentString = NSAttributedString(attachment: attachment)
        let myString = NSMutableAttributedString(string: " ")
        myString.append(attachmentString)
        let myStringAfter = NSMutableAttributedString(string: " SMILE TO PLAY")
        myString.append(myStringAfter)
        label4.attributedText = myString
        label4.translatesAutoresizingMaskIntoConstraints = false
        label4.textColor = .white
        label4.numberOfLines = 0
        label4.textAlignment = .center
        label4.font = .inikaBold(ofSize: 20)
        label4.contentMode = .scaleAspectFill
        label4.sizeToFit()
        label4.fitTextToBounds()
        return label4
    }()
    
    lazy var progressView: UIProgressView = {
        let progressView = UIProgressView(progressViewStyle: .default)
        progressView.translatesAutoresizingMaskIntoConstraints = false
        progressView.trackTintColor = .secondaryBackground
        progressView.progressTintColor = .white.withAlphaComponent(0.4)
        progressView.layer.cornerRadius = 20
        progressView.clipsToBounds = true
        return progressView
    }()
    
    //MARK: - Mage Image
//    let mageImage: UIImageView = {
//        let imageView = UIImageView(frame: .zero)
//        imageView.translatesAutoresizingMaskIntoConstraints = false
//        imageView.clipsToBounds = true
//        imageView.image = UIImage(named: "mageWithOrbs")
//        imageView.contentMode = .scaleAspectFit
//        imageView.setContentCompressionResistancePriority(.defaultLow, for: .vertical)
//        return imageView
//    }()
    
    lazy var buttonSettings: UIBarButtonItem = {
        let button = UIButton(frame: CGRect(x: 0, y: 0, width: 44, height: 44))
        button.backgroundColor = .white
        button.setImage(UIImage(systemName: "gearshape.fill"), for: .normal)
        button.tintColor = .label
        button.layer.cornerRadius = 20
        button.addTarget(self, action: #selector(onSettingsButtonPush), for: .touchUpInside)
        button.clipsToBounds = true
        let barButtonItem = UIBarButtonItem(customView: button)
        return barButtonItem
    }()
    
    lazy var leaderboardButton: UIBarButtonItem = {
        let button = UIButton(frame: CGRect(x: 0, y: 0, width: 44, height: 44))
        button.backgroundColor = .white
        button.setImage(UIImage(named: "podium"), for: .normal)
        button.tintColor = .label
        button.layer.cornerRadius = 20
        button.addTarget(self, action: #selector(onLeaderboardLibraryButtonPush), for: .touchUpInside)
        button.clipsToBounds = true
        let barButtonItem = UIBarButtonItem(customView: button)
        return barButtonItem
    }()
    
    let buttonSongLibrary: UIButton = {
        let button3 = UIButton(frame: .zero)
        var songText = " Song Library"
        button3.backgroundColor = .white
        button3.setImage(UIImage(systemName: "music.note"), for: .normal)
        button3.tintColor = .label
        button3.setTitle(songText.uppercased(), for: .normal)
        button3.setTitleColor(.label, for: .normal)
        button3.titleLabel!.font = .inikaBold(ofSize: 20)
        button3.layer.cornerRadius = 20
        button3.addTarget(self, action: #selector(onSongLibraryButtonPush), for: .touchUpInside)
        return button3
    }()
    
    func assignbackground(){
        let background = UIImage(named: "background")
        
        var imageView : UIImageView!
        imageView = UIImageView(frame: self.bounds)
        imageView.contentMode =  UIView.ContentMode.scaleAspectFill
        imageView.clipsToBounds = true
        imageView.image = background
        imageView.center = self.center
        self.addSubview(imageView)
        self.sendSubviewToBack(imageView)
    }
    
    func setupLayout() {
        handleAutoResizingMasks()
        
        nameGameTitle.widthAnchor.constraint(equalTo: self.widthAnchor, multiplier: 1, constant: 0).isActive = true
        nameGameTitle.topAnchor.constraint(equalTo: self.layoutMarginsGuide.topAnchor).isActive = true
        nameGameTitle.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
        
        nameSongTitle.widthAnchor.constraint(equalTo: self.widthAnchor, multiplier: 0.8).isActive = true
        nameSongTitle.topAnchor.constraint(equalTo: nameGameTitle.bottomAnchor).isActive = true
        nameSongTitle.bottomAnchor.constraint(equalTo: bestScoreTitle.topAnchor).isActive = true
        nameSongTitle.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
        
        bestScoreTitle.widthAnchor.constraint(equalTo: self.widthAnchor, multiplier: 1, constant: 0).isActive = true
        bestScoreTitle.bottomAnchor.constraint(equalTo: previewCameraLayer.topAnchor, constant: -20).isActive = true
        bestScoreTitle.topAnchor.constraint(equalTo: nameSongTitle.bottomAnchor).isActive = true
        bestScoreTitle.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
        
//        mageImage.widthAnchor.constraint(equalTo: self.widthAnchor, multiplier: 0.85).isActive = true
//        mageImage.topAnchor.constraint(equalTo: bestScoreTitle.bottomAnchor, constant: 20).isActive = true
//        mageImage.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
        
        previewCameraLayer.widthAnchor.constraint(lessThanOrEqualTo: self.widthAnchor).isActive = true
        previewCameraLayer.heightAnchor.constraint(equalTo: previewCameraLayer.widthAnchor).isActive = true
        previewCameraLayer.topAnchor.constraint(equalTo: bestScoreTitle.bottomAnchor, constant: 20).isActive = true
        previewCameraLayer.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
        
        smileToPlayTitle.centerXAnchor.constraint(equalTo: progressView.centerXAnchor).isActive = true
        smileToPlayTitle.centerYAnchor.constraint(equalTo: progressView.centerYAnchor).isActive = true
        
        progressView.widthAnchor.constraint(equalTo: buttonSongLibrary.widthAnchor).isActive = true
        progressView.topAnchor.constraint(equalTo: previewCameraLayer.bottomAnchor, constant: 25).isActive = true
        progressView.bottomAnchor.constraint(equalTo: buttonSongLibrary.topAnchor, constant: -20).isActive = true
        progressView.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
        progressView.heightAnchor.constraint(equalTo: buttonSongLibrary.heightAnchor).isActive = true
        
        buttonSongLibrary.widthAnchor.constraint(equalTo: self.widthAnchor, multiplier: 0.85).isActive = true
        buttonSongLibrary.topAnchor.constraint(equalTo: progressView.bottomAnchor, constant: 20).isActive = true
        buttonSongLibrary.heightAnchor.constraint(equalToConstant: 51).isActive = true
        buttonSongLibrary.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -42).isActive = true
        buttonSongLibrary.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
        
        gradientView.topAnchor.constraint(equalTo: self.topAnchor).isActive = true
        gradientView.leadingAnchor.constraint(equalTo: self.leadingAnchor).isActive = true
        gradientView.trailingAnchor.constraint(equalTo: self.trailingAnchor).isActive = true
        gradientView.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive = true
        
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        faceTrackingView.setFrame(frame: previewCameraLayer.frame, circle: true)
        
    }
    
    public func requestModel (user: User, level: Level)
    {
        nameSongTitle.text = "Now Playing: \(level.songName) by \(level.artistName)"
    }
    
    func setBestScore(score: String) {
        bestScoreTitle.text = "Best Score: " + score
    }
    
    @objc func onSettingsButtonPush(){
        delegate?.onSettingsButtonPush()
    }
    
    @objc func onSongLibraryButtonPush(){
        delegate?.onSongLibraryButtonPush()
    }
    
    @objc func onLeaderboardLibraryButtonPush() {
        delegate?.onLeaderboardButtonPush()
    }
    
    func handleAutoResizingMasks() {
        previewCameraLayer.translatesAutoresizingMaskIntoConstraints = false
        nameGameTitle.translatesAutoresizingMaskIntoConstraints = false
        nameSongTitle.translatesAutoresizingMaskIntoConstraints = false
        bestScoreTitle.translatesAutoresizingMaskIntoConstraints = false
//        mageImage.translatesAutoresizingMaskIntoConstraints = false
        buttonSongLibrary.translatesAutoresizingMaskIntoConstraints = false
        gradientView.translatesAutoresizingMaskIntoConstraints = false
            
    }
}

extension UIFont {
    
    /**
     Will return the best font conforming to the descriptor which will fit in the provided bounds.
     */
    static func bestFittingFontSize(for text: String, in bounds: CGRect, fontDescriptor: UIFontDescriptor, additionalAttributes: [NSAttributedString.Key: Any]? = nil) -> CGFloat {
        let constrainingDimension = min(bounds.width, bounds.height)
        let properBounds = CGRect(origin: .zero, size: bounds.size)
        var attributes = additionalAttributes ?? [:]
        
        let infiniteBounds = CGSize(width: CGFloat.infinity, height: CGFloat.infinity)
        var bestFontSize: CGFloat = constrainingDimension
        
        for fontSize in stride(from: bestFontSize, through: 0, by: -1) {
            let newFont = UIFont(descriptor: fontDescriptor, size: fontSize)
            attributes[.font] = newFont
            
            let currentFrame = text.boundingRect(with: infiniteBounds, options: [.usesLineFragmentOrigin, .usesFontLeading], attributes: attributes, context: nil)
            
            if properBounds.contains(currentFrame) {
                bestFontSize = fontSize
                break
            }
        }
        return bestFontSize
    }
    
    static func bestFittingFont(for text: String, in bounds: CGRect, fontDescriptor: UIFontDescriptor, additionalAttributes: [NSAttributedString.Key: Any]? = nil) -> UIFont {
        let bestSize = bestFittingFontSize(for: text, in: bounds, fontDescriptor: fontDescriptor, additionalAttributes: additionalAttributes)
        return UIFont(descriptor: fontDescriptor, size: bestSize)
    }
}

extension UILabel {
    
    /// Will auto resize the contained text to a font size which fits the frames bounds.
    /// Uses the pre-set font to dynamically determine the proper sizing
    func fitTextToBounds() {
        guard let text = text, let currentFont = font else { return }
        
        let bestFittingFont = UIFont.bestFittingFont(for: text, in: bounds, fontDescriptor: currentFont.fontDescriptor, additionalAttributes: basicStringAttributes)
        font = bestFittingFont
    }
    
    private var basicStringAttributes: [NSAttributedString.Key: Any] {
        var attribs = [NSAttributedString.Key: Any]()
        
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.alignment = self.textAlignment
        paragraphStyle.lineBreakMode = self.lineBreakMode
        attribs[.paragraphStyle] = paragraphStyle
        
        return attribs
    }
}

