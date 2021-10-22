//
//  SongContainerView.swift
//  RhythMage
//
//  Created by Juliana Prado on 14/10/21.
//

import UIKit
import AVFoundation

enum SongContainerType {
    case lockedSong
    case unlockedSong
    case buyableSong
    case playingSong
}

class SongContainerView:UIView {
    var highestScore = 0.0
    var score: Int = 9999
    var multiplier = 1
    
    var player: AVAudioPlayer!
    
    var height: CGFloat = 0
    var xPosition: CGFloat = 0
    var imageSize: CGFloat = 36
    
    var isPlaying = false
    
    var encouragements = ["That's great!","Wonderful!","Ready, Set, Face Magic!","Good!", "Excellent!", "Don't give up!", "You are really struggling!"]
    
    var type: SongContainerType = {
        return .buyableSong
    }()
    
    ///icon with the play symbol
    private let iconImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.tintColor = .white
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    ///highest score label
    private let backgroundView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
//        view.backgroundColor = .blue
        view.clipsToBounds = true
        view.layer.cornerRadius = 20
        view.layer.borderWidth = 3
        view.layer.masksToBounds = true
        return view
    }()
    
    ///highest score label
    private let highestScoreLabel: DynamicLabel = {
       let label = DynamicLabel()
        label.font = .inikaBold(ofSize: 15)
        label.numberOfLines = 1
        label.textColor = .secondary
        return label
    }()
    ///Song title Label
    private let songTitleLabel: DynamicLabel = {
       let label = DynamicLabel()
        label.font = .inikaBold(ofSize: 18)
        label.numberOfLines = 1
        label.textColor = .secondary
        return label
    }()
    ///Artist Name Label
    private let artistNameLabel: DynamicLabel = {
       let label = DynamicLabel()
        label.font = .inika(ofSize: 15)
        label.numberOfLines = 1
        label.textColor = .secondary
        return label
    }()
    ///"unlock by scoring" label
    private let unlockByLabel: DynamicLabel = {
       let label = DynamicLabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .inikaBold(ofSize: 18)
        label.numberOfLines = 2
        label.textAlignment = .center
        label.textColor = .white
        return label
    }()
    ///"xxxx points" Label
    private let pointsLabel: DynamicLabel = {
       let label = DynamicLabel()
        label.font = .inikaBold(ofSize: 18)
        label.numberOfLines = 2
        label.textColor = .white
        return label
    }()
    ///StackView containing the Labels
    var encouragementLabel: DynamicLabel = {
        let label = DynamicLabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .inikaBold(ofSize: 18)
        label.numberOfLines = 2
        label.textAlignment = .center
        label.textColor = .white
        return label
    }()
    ///Multiplier label
    let multiplierTitle: UILabel = {
        let label4 = UILabel(frame: .zero)
        let attachment = NSTextAttachment()
        attachment.image = UIImage(systemName: "star.fill")?.withTintColor(.white)
        let imageOffsetY: CGFloat = -1.0
        attachment.bounds = CGRect(x: 0, y: imageOffsetY, width: attachment.image!.size.width, height: attachment.image!.size.height)
        let attachmentString = NSAttributedString(attachment: attachment)
        let myString = NSMutableAttributedString(string: " 9X")
        myString.append(attachmentString)
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
    ///StackView containing the Labels
    var labelsStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        stackView.distribution = .fill
        return stackView
    }()
  
    init(type: SongContainerType) {
        super.init(frame: .zero)

        self.type = type
        
        switch type {
        case .lockedSong:
            unlockByLabel.text = "Unlock by scoring \(score) points in the previous level"
            setupHiararchyLockedSong()
            iconImageView.image = UIImage(systemName: "lock.fill")
            break
        case .unlockedSong:
            setupHiararchyUnlockedSong()
            iconImageView.image = UIImage(systemName: "play.circle.fill")
            let tapGestureRecognizer = UITapGestureRecognizer(target:self, action: #selector(togglePlaySong(_:)))
            iconImageView.isUserInteractionEnabled = true
            iconImageView.addGestureRecognizer(tapGestureRecognizer)
            break
        case .buyableSong:
            iconImageView.image = UIImage(systemName: "play.circle.fill")
            setupHiararchyLockedSong()
            break
        case .playingSong:
            iconImageView.image = UIImage(systemName: "pause.circle.fill")
            let tapGestureRecognizer = UITapGestureRecognizer(target:self, action: #selector(togglePlayGame(_:)))
            iconImageView.isUserInteractionEnabled = true
            iconImageView.addGestureRecognizer(tapGestureRecognizer)
            setupHierarchyPlayingSong()
            break
        }
//        backgroundView.backgroundColor = .clear
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - LayoutSubviews
    override func layoutSubviews() {
        switch self.type {
        case .unlockedSong:
            layoutSubviewsUnlockedSong()
            break
        case .lockedSong:
            layoutSubviewsLockedSong()
            break
        case .playingSong:
            layoutSubviewsPlayingSong()
            break
        case .buyableSong:
            break
        }
    }
    
    func layoutSubviewsLockedSong(){
        NSLayoutConstraint.activate([
            unlockByLabel.leadingAnchor.constraint(equalTo: iconImageView.trailingAnchor, constant: 20),
            unlockByLabel.trailingAnchor.constraint(equalTo: self.layoutMarginsGuide.trailingAnchor, constant: -20),
            unlockByLabel.centerYAnchor.constraint(equalTo: self.centerYAnchor)
        ])
        
        iconImageView.frame = CGRect(x: 20, y: (self.frame.size.height - imageSize - 5) / 2, width: imageSize, height: imageSize)
    }
    
    func layoutSubviewsUnlockedSong(){
        height = self.frame.size.height
        xPosition = self.frame.size.width - 24
        iconImageView.frame = CGRect(x: (xPosition - imageSize), y: (height - imageSize) / 2, width: imageSize, height: imageSize)
        
        NSLayoutConstraint.activate([
            labelsStackView.topAnchor.constraint(equalTo: backgroundView.topAnchor, constant: 10),
            labelsStackView.leadingAnchor.constraint(equalTo: backgroundView.leadingAnchor, constant: 24),
            labelsStackView.trailingAnchor.constraint(equalTo: iconImageView.leadingAnchor),
            
            
            backgroundView.widthAnchor.constraint(equalTo: self.widthAnchor),
            backgroundView.heightAnchor.constraint(equalTo: self.heightAnchor),
        ])
    }
    
    func layoutSubviewsPlayingSong(){
        height = self.frame.size.height
        xPosition = self.frame.size.width - 14
        iconImageView.frame = CGRect(x: (xPosition - imageSize), y: (height - imageSize) / 7, width: imageSize, height: imageSize)
        
        NSLayoutConstraint.activate([
            labelsStackView.topAnchor.constraint(equalTo: backgroundView.topAnchor, constant: 10),
            labelsStackView.leadingAnchor.constraint(equalTo: backgroundView.leadingAnchor, constant: 24),
            labelsStackView.trailingAnchor.constraint(equalTo: iconImageView.leadingAnchor, constant: 10),
            
            multiplierTitle.trailingAnchor.constraint(equalTo: backgroundView.trailingAnchor, constant: -14),
            multiplierTitle.topAnchor.constraint(equalTo: iconImageView.bottomAnchor),
            
            backgroundView.widthAnchor.constraint(equalTo: self.widthAnchor),
            backgroundView.heightAnchor.constraint(equalTo: self.heightAnchor),
        ])
    }
    
    //MARK: - Hierarchy Functions
    func setupHiararchyLockedSong(){
        addSubview(unlockByLabel)
        addSubview(iconImageView)
        addSubview(pointsLabel)
    }
    
    func setupHiararchyUnlockedSong(){
        self.addSubview(backgroundView)
        labelsStackView.addArrangedSubview(highestScoreLabel)
        labelsStackView.addArrangedSubview(songTitleLabel)
        labelsStackView.addArrangedSubview(artistNameLabel)
        backgroundView.addSubview(labelsStackView)
        backgroundView.addSubview(iconImageView)
    }
    
    func setupHierarchyPlayingSong(){
        self.addSubview(backgroundView)
        labelsStackView.addArrangedSubview(encouragementLabel)
        labelsStackView.addArrangedSubview(pointsLabel)
        backgroundView.addSubview(labelsStackView)
        backgroundView.addSubview(multiplierTitle)
        backgroundView.addSubview(iconImageView)
    }
    
    //MARK: - Configuration
    ///Prepares the cell to be reused
    func prepareForReuse() {
        highestScoreLabel.text = nil
        songTitleLabel.text = nil
        artistNameLabel.text = nil
        unlockByLabel.text = nil
        pointsLabel.text = nil
    }
    
    
    ///Configures the cell for usage
    public func configure(with model: Level, and userModel: User){
        switch type {
        case .lockedSong:
            break
        case .unlockedSong:
            artistNameLabel.text = model.artistName.uppercased()
            songTitleLabel.text = model.songName.uppercased()
            if let highest = userModel.completed[model.getId()] {
                highestScore = highest
            }
            highestScoreLabel.text = "Highest Score: "+String(highestScore)
        case .playingSong:
            encouragementLabel.text = encouragements[0]
            break
        case .buyableSong:
            break
        }
        
    }
    
    @objc func togglePlaySong(_ sender: UITapGestureRecognizer){
        isPlaying = !isPlaying
        if isPlaying{
            iconImageView.image = UIImage(systemName: "pause.circle.fill")
            guard let path = Bundle.main.path(forResource: songTitleLabel.text, ofType: "mp3") else {
                print("No file.")
                return}
            let url = URL(fileURLWithPath: path)
            do {
                player = try AVAudioPlayer(contentsOf: url)
                guard let player = player else {return}
                player.play()
            }
            catch let error{
                print(error.localizedDescription)
            }
        } else {
            iconImageView.image = UIImage(systemName: "play.circle.fill")
           
        }
    }
    
    @objc func togglePlayGame(_ sender: UITapGestureRecognizer){
        isPlaying = !isPlaying
        if isPlaying{
            iconImageView.image = UIImage(systemName: "pause.circle.fill")
        } else {
            iconImageView.image = UIImage(systemName: "play.circle.fill")
           
        }
    
    }
    
}
