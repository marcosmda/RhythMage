//
//  SongLibraryUnlockedSongCell.swift
//  RhythMage
//
//  Created by Juliana Prado on 05/10/21.
//

import UIKit

class SongLibraryUnlockedSongCell: UITableViewCell{
    
    //MARK: - Properties
    static let reusableIdentifier = "SongLibraryUnlockedSongCell"
    var delegate: SongLibraryViewDelegate?

    ///icon with the play symbol
    private let iconImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.tintColor = .white
        imageView.image = UIImage(systemName: "play.circle.fill")
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    ///highest score as a Double
    private var highestScore = 0.0
    
    ///highest score label
    private let highestScoreLabel: DynamicLabel = {
       let label = DynamicLabel()
        label.font = UIFont(name: "Inika-Bold", size: 15)
        label.numberOfLines = 1
        return label
    }()
    ///Song title Label
    private let songTitleLabel: DynamicLabel = {
       let label = DynamicLabel()
        label.font = UIFont(name: "Inika-Bold", size: 18)
        label.numberOfLines = 1
        return label
    }()
    ///Artist Name Label
    private let artistNameLabel: DynamicLabel = {
       let label = DynamicLabel()
        label.font = UIFont(name: "Inika", size: 15)
        label.numberOfLines = 1
        return label
    }()
    ///StackView containing the Labels
    var labelsStackView: UIStackView = {
       let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        return stackView
    }()
    
    //MARK: - Initializers
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: SongLibraryUnlockedSongCell.reusableIdentifier)
        
        self.backgroundColor = UIColor(red: 0.158, green: 0.156, blue: 0.156, alpha: 0.5)
        
        contentView.clipsToBounds = false
        accessoryType = .disclosureIndicator
        
        setupHierarchy()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - Layout Subviews
    override func layoutSubviews() {
        super.layoutSubviews()
        highestScoreLabel.text = "Highest Score: "+String(highestScore)

        let height: CGFloat = contentView.frame.size.height
        let xPosition: CGFloat = contentView.frame.size.width - 15
        let imageSize: CGFloat = 36
        iconImageView.frame = CGRect(x: (xPosition - imageSize), y: (height - imageSize) / 2, width: imageSize, height: imageSize)
        
        NSLayoutConstraint.activate([
            labelsStackView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 7),
            labelsStackView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
            labelsStackView.rightAnchor.constraint(equalTo: self.iconImageView.leftAnchor)
        ])
    }
    
    func setupHierarchy(){
        labelsStackView.addArrangedSubview(highestScoreLabel)
        labelsStackView.addArrangedSubview(songTitleLabel)
        labelsStackView.addArrangedSubview(artistNameLabel)
        addSubview(labelsStackView)
        addSubview(iconImageView)
    }
    
    //MARK: - Configuration
    ///Prepares the cell to be reused
    override func prepareForReuse() {
        super.prepareForReuse()
        highestScoreLabel.text = nil
        songTitleLabel.text = nil
        artistNameLabel.text = nil
    }
    
    ///Configures the cell for usage
    public func configure(with model: Level, and userModel: User){
        artistNameLabel.text = model.artistName.uppercased()
        songTitleLabel.text = model.songName.uppercased()
        if let highest = userModel.completed[model.getId()] {
            highestScore = highest
        }
        
    }
    
}
