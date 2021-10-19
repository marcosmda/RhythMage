//
//  SongContainerView.swift
//  RhythMage
//
//  Created by Juliana Prado on 14/10/21.
//

import UIKit

enum SongContainerType {
    case lockedSong
    case unlockedSong
    case buyableSong
    case playingSong
}

class SongContainerView:UIView {
    var highestScore = 0.0
    var score: Int = 9999
    
    var height: CGFloat = 0
    var xPosition: CGFloat = 0
    var imageSize: CGFloat = 0
    
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
            imageSize = 36
            setupHiararchyLockedSong()
            iconImageView.image = UIImage(systemName: "lock.fill")
            break
        case .unlockedSong:
            imageSize = 36
            setupHiararchyUnlockedSong()
            iconImageView.image = UIImage(systemName: "play.circle.fill")
            break
        case .buyableSong:
            iconImageView.image = UIImage(systemName: "play.circle.fill")
            setupHiararchyLockedSong()
            break
        case .playingSong:
            iconImageView.image = UIImage(systemName: "play.circle.fill")
            break
        }
        
       
        backgroundView.backgroundColor = .clear
        
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    override func layoutSubviews() {
        
        switch self.type {
        case .unlockedSong:
            layoutSubviewsUnlockedSong()
            break
        case .lockedSong:
            layoutSubviewsLockedSong()
            break
        case .playingSong:
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
        
        iconImageView.frame = CGRect(x: 20, y: (self.frame.size.height - imageSize) / 2, width: imageSize, height: imageSize)
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
            break
        case .buyableSong:
            break
        }
        
    }
}
