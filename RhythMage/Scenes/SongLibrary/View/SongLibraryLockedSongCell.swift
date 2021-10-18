//
//  SongLibraryLockedSongCell.swift
//  RhythMage
//
//  Created by Juliana Prado on 07/10/21.
//

import UIKit

class SongLibraryLockedSongCell: UITableViewCell {
    
    //MARK: - Properties
    static let reusableIdentifier = "SongLibraryLockedSongCell"
    var delegate: SongLibraryViewDelegate?
    
    ///icon with the play symbol
    private let iconImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.tintColor = .white
        imageView.image = UIImage(systemName: "lock.fill")
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    ///"unlock by scoring" label
    private let unlockByLabel: DynamicLabel = {
       let label = DynamicLabel()
        label.font = .inikaBold(ofSize: 18)
        label.numberOfLines = 1
        return label
    }()
    ///"xxxx points" Label
    private let pointsLabel: DynamicLabel = {
       let label = DynamicLabel()
        label.font = .inikaBold(ofSize: 18)
        label.numberOfLines = 2
        return label
    }()
    
    
    //MARK: - Initializers
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: SongLibraryUnlockedSongCell.reusableIdentifier)
        
        self.backgroundColor = UIColor(red: 0.158, green: 0.156, blue: 0.156, alpha: 1)
        
        contentView.clipsToBounds = true
        accessoryType = .disclosureIndicator
        
        
        
        setupHierarchy()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - Layout Subviews
    override func layoutSubviews() {
        super.layoutSubviews()
        
        unlockByLabel.text = "Highest Score: "

        contentView.frame = contentView.frame.inset(by: UIEdgeInsets(top: 50, left: 50, bottom: 50, right: 50))
        
        let height: CGFloat = contentView.frame.size.height * 1.5
        let xPosition: CGFloat = contentView.frame.size.width
        let imageSize: CGFloat = 36
        iconImageView.frame = CGRect(x: (xPosition - imageSize) / 2, y: (height - imageSize) / 2, width: imageSize, height: imageSize)
        
        NSLayoutConstraint.activate([
            
        ])
    }
    
    func setupHierarchy(){
        addSubview(unlockByLabel)
        addSubview(iconImageView)
        addSubview(pointsLabel)
    }
    
    //MARK: - Configuration
    ///Prepares the cell to be reused
    override func prepareForReuse() {
        super.prepareForReuse()
        unlockByLabel.text = nil
        pointsLabel.text = nil
    }
    
    ///Configures the cell for usage
    public func configure(with model: Level, and userModel: User){
        
        
    }
    
    
}
