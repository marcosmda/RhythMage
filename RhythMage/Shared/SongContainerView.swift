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
    var score: Int = 99999
    
    var player: AVAudioPlayer!
    
    var height: CGFloat = 0
    var xPosition: CGFloat = 0
    var imageSize: CGFloat = 36
    
    var isPlaying = false
    
    var gameDelegate: GameSceneDelegate?
    var libraryDelegate: SongLibraryViewDelegate?
    
    var encouragements = ["Ready, Set, Face Magic!","Excellent!","That's great!","Good!", "Don't give up!", "You are really struggling!"]
    
    var type: SongContainerType = {
        return .buyableSong
    }()
    
    ///icon with the play symbol
    let iconImageView: UIImageView = {
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
    let songTitleLabel: DynamicLabel = {
       let label = DynamicLabel()
        label.translatesAutoresizingMaskIntoConstraints = false
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
    let pointsLabel: DynamicLabel = {
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
        label.font = .inika(ofSize: 18)
        label.numberOfLines = 2
        label.textAlignment = .left
        label.textColor = .white
        return label
    }()
    ///Multiplier label
    let multiplierTitle: UILabel = {
        let label4 = UILabel(frame: .zero)
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
    ///progress bar
    private lazy var progressView: UIProgressView = {
        let progressView = UIProgressView(progressViewStyle: .default)
        progressView.translatesAutoresizingMaskIntoConstraints = false
        progressView.trackTintColor = .white
        progressView.progressTintColor = .clear
        progressView.layer.cornerRadius = 8.4
        progressView.clipsToBounds = true
        progressView.layer.borderWidth = 1
        progressView.layer.borderColor = UIColor.white.cgColor
        return progressView
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
            let tapGestureRecognizer = UITapGestureRecognizer(target:self, action: #selector(togglePlaySong))
            iconImageView.isUserInteractionEnabled = true
            iconImageView.addGestureRecognizer(tapGestureRecognizer)
            break
        case .buyableSong:
            iconImageView.image = UIImage(systemName: "play.circle.fill")
            setupHiararchyLockedSong()
            break
        case .playingSong:
            setEncouragementLabelAndMultiplier(with: 1)
            iconImageView.image = UIImage(systemName: "pause.circle.fill")
            
            backgroundView.backgroundColor = .clear
            backgroundView.layer.borderWidth = 0
            pointsLabel.text = String(0)
            setupHierarchyPlayingSong()
            break
        }
        
       
        
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
    public func configure(with model: Level, userModel: User?){
        switch type {
        case .lockedSong:
            break
        case .unlockedSong:
            artistNameLabel.text = model.artistName.uppercased()
            songTitleLabel.text = model.songName.uppercased()
            if let user = userModel?.completed[model.getId()] {
                highestScore = Double(user) ?? 0
            }
            highestScoreLabel.text = "Highest Score: "+String(highestScore)
        case .playingSong:
            songTitleLabel.text = model.songName.uppercased()
            //
            break
        case .buyableSong:
            break
        }
    }
   
    
    
}

//MARK: - Locked Song Container Type
extension SongContainerView{
    
    /// layoutSubviewsLockedSong
    func layoutSubviewsLockedSong(){
        NSLayoutConstraint.activate([
            unlockByLabel.leadingAnchor.constraint(equalTo: iconImageView.trailingAnchor, constant: 20),
            unlockByLabel.trailingAnchor.constraint(equalTo: self.layoutMarginsGuide.trailingAnchor, constant: -20),
            unlockByLabel.centerYAnchor.constraint(equalTo: self.centerYAnchor)
        ])
        
        iconImageView.frame = CGRect(x: 20, y: (self.frame.size.height - imageSize - 5) / 2, width: imageSize, height: imageSize)
    }
    
    /// setupHiararchyLockedSong
    func setupHiararchyLockedSong(){
        addSubview(unlockByLabel)
        addSubview(iconImageView)
        addSubview(pointsLabel)
    }
    
}

//MARK: - Unlocked Song Contaniner Type
extension SongContainerView {
    
    /// setupHiararchyUnlockedSong
    func setupHiararchyUnlockedSong(){
        self.addSubview(backgroundView)
        labelsStackView.addArrangedSubview(highestScoreLabel)
        labelsStackView.addArrangedSubview(songTitleLabel)
        labelsStackView.addArrangedSubview(artistNameLabel)
        backgroundView.addSubview(labelsStackView)
        backgroundView.addSubview(iconImageView)
    }
    
    /// layoutSubviewsUnlockedSong
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
    
    /// Toggle Play used by Unlocked Song Container
    @objc func togglePlaySong(){
        libraryDelegate?.didPlaySong(songName: songTitleLabel.text ?? "")
        isPlaying.toggle()
        
        if !isPlaying {
            iconImageView.image = UIImage(systemName: "play.circle.fill")
            player.stop()
        }
        
        else {
            iconImageView.image = UIImage(systemName: "pause.circle.fill")
            guard let path = Bundle.main.path(forResource: "fairy-tale-waltz", ofType: "mp3") else {
                print("No file.")
                return
            }
            let url = URL(fileURLWithPath: path)
            do {
                player = try AVAudioPlayer(contentsOf: url)
                guard let player = player else {return}
                player.play()
            }
            catch let error{
                print(error.localizedDescription)
            }
        }
    }
    
}

//MARK: - Playing Song Container Type
extension SongContainerView {
    
    /// layoutSubviewsPlayingSong
    func layoutSubviewsPlayingSong(){
        height = self.frame.size.height
        xPosition = self.frame.size.width - 14
        iconImageView.frame = CGRect(x: (xPosition - imageSize), y: (height - imageSize) / 7, width: imageSize, height: imageSize)
        
        NSLayoutConstraint.activate([
            labelsStackView.topAnchor.constraint(equalTo: backgroundView.topAnchor, constant: 10),
            labelsStackView.leadingAnchor.constraint(equalTo: backgroundView.leadingAnchor, constant: 12),
            labelsStackView.trailingAnchor.constraint(equalTo: iconImageView.leadingAnchor, constant: -10),
            labelsStackView.bottomAnchor.constraint(equalTo: multiplierTitle.bottomAnchor),
            
            multiplierTitle.trailingAnchor.constraint(equalTo: backgroundView.trailingAnchor, constant: -14),
            multiplierTitle.topAnchor.constraint(equalTo: iconImageView.bottomAnchor, constant: 6),
            
            backgroundView.widthAnchor.constraint(equalTo: self.widthAnchor),
            backgroundView.heightAnchor.constraint(equalTo: self.heightAnchor),
        ])
    }
    
    /// setupHierarchyPlayingSong
    func setupHierarchyPlayingSong(){
        self.addSubview(backgroundView)
        labelsStackView.addArrangedSubview(songTitleLabel)
        //labelsStackView.addArrangedSubview(encouragementLabel) //TODO: Change back do encouragement Label when needed
        labelsStackView.addArrangedSubview(pointsLabel)
        backgroundView.addSubview(labelsStackView)
        backgroundView.addSubview(multiplierTitle)
        backgroundView.addSubview(iconImageView)
    }
    
    /// Sets the encouragement label based on the multiplier recieved
    /// Sets multiplier label based on the multiplier recieved
    /// - Parameter multiplier: Multiplier (Int) is the amount of times a player has consecutively won points
    public func setEncouragementLabelAndMultiplier(with multiplier: Int){
        let attachment = NSTextAttachment()
        let myString = NSMutableAttributedString(string: "")
        attachment.image = UIImage(systemName: "star.fill")?.withTintColor(.white)
        let imageOffsetY: CGFloat = -1.0
        attachment.bounds = CGRect(x: 0, y: imageOffsetY, width: attachment.image!.size.width, height: attachment.image!.size.height)
        let attachmentString = NSAttributedString(attachment: attachment)
        myString.append(attachmentString)
        switch multiplier{
       
        case 1:
            encouragementLabel.text = encouragements[5]
            myString.append(NSAttributedString(string: "1X"))
            break
        case 2:
            encouragementLabel.text = encouragements[4]
            myString.append(NSAttributedString(string: "2X"))
            break
        case 4:
            encouragementLabel.text = encouragements[3]
            myString.append(NSAttributedString(string: "4X"))
            break
        case 6:
            encouragementLabel.text = encouragements[2]
            myString.append(NSAttributedString(string: "6X"))
            break
        case 8:
            encouragementLabel.text = encouragements[1]
            myString.append(NSAttributedString(string: "8X"))
            break
        case 10:
            encouragementLabel.text = encouragements[0]
            myString.append(NSAttributedString(string: "10X"))
            break
        default:
            print("Unrecognized Multiplier.")
        }
        multiplierTitle.attributedText = myString
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
                highestScore = Double(highest) ?? 0
            }
            highestScoreLabel.text = "Highest Score: "+String(highestScore)
        case .playingSong:
            pointsLabel.text = String(score)
            break
        case .buyableSong:
            break
        }
    }
    
    func stopSong() {
        player.stop()
        libraryDelegate?.didStopSong()
    }
    
    
    
    /// Pauses the game when the Icon Image is tapped
    /// - Parameter sender: UITapGestureRecognizer
    @objc func togglePlayGame(_ sender: UITapGestureRecognizer){
        gameDelegate?.pauseGame()
    }
    
    public func setScore(score: Int){
        pointsLabel.text = String(score.formattedWithSeparator)
    }
    
}


//MARK: - Extention for Int Formatter
extension Formatter {
    static let withSeparator: NumberFormatter = {
        let formatter = NumberFormatter()
        formatter.groupingSeparator = ","
        formatter.numberStyle = .decimal
        return formatter
    }()
}

extension Numeric {
    var formattedWithSeparator: String {
        Formatter.withSeparator.string(for: self) ?? ""
    }
}
