//
//  SongLibraryOwnedSongsCell.swift
//  RhythMage
//
//  Created by Juliana Prado on 05/10/21.
//

import UIKit

class SongLibraryOwnedSongsCell: UITableViewCell{
    
    //MARK: - Properties
    static let reusableIdentifier = "SettingsTableViewSwitchCell"
    var delegate: SongLibraryViewDelegate?

    ///icon with the play symbol
    private let iconImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.tintColor = .black
        imageView.image = UIImage(systemName: "play.circle.fill")
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    ///highest score as a Double
    private var highestScore = 0.0
    
    ///highest score label
    private let highestScoreLabel: DynamicLabel = {
       let label = DynamicLabel()
        label.numberOfLines = 1
        return label
    }()
    ///Song title Label
    private let songTitleLabel: DynamicLabel = {
       let label = DynamicLabel()
        label.numberOfLines = 1
        return label
    }()
    ///Artist Name Label
    private let artistNameLabel: DynamicLabel = {
       let label = DynamicLabel()
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
    ///StackView with labels and Icon
    var stackView: UIStackView = {
        let stackView = UIStackView()
         stackView.translatesAutoresizingMaskIntoConstraints = false
         stackView.axis = .horizontal
         
         return stackView
     }()
    
    //MARK: - Initializers
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: SongLibraryOwnedSongsCell.reusableIdentifier)
        
        self.backgroundColor = UIColor.black
        
        contentView.clipsToBounds = true
        accessoryType = .none
        
        setupHierarchy()
        setupLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - Layout Subviews
    
    func setupLayout() {
        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(equalTo: contentView.topAnchor),
            stackView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            stackView.trailingAnchor.constraint(equalTo: contentView.layoutMarginsGuide.trailingAnchor),
            stackView.heightAnchor.constraint(equalTo: contentView.heightAnchor, multiplier: 0.65),
        ])
        
    }
    
    func setupHierarchy(){
        labelsStackView.addSubview(highestScoreLabel)
        labelsStackView.addSubview(songTitleLabel)
        labelsStackView.addSubview(artistNameLabel)
        stackView.addSubview(labelsStackView)
        stackView.addSubview(iconImageView)
        addSubview(stackView)
        
        
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
        artistNameLabel.text = model.artistName
        songTitleLabel.text = model.artistName
        if let highest = userModel.completed[model.getId()] {
            highestScore = highest
        }
        
    }
    
}
