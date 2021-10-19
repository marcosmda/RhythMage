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
    public var song: SongContainerView
    
    //MARK: - Initializers
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        self.song = SongContainerView(type: .unlockedSong)
        self.song.translatesAutoresizingMaskIntoConstraints = false
       
        super.init(style: style, reuseIdentifier: SongLibraryUnlockedSongCell.reusableIdentifier)
        self.backgroundColor = UIColor(red: 0.158, green: 0.156, blue: 0.156, alpha: 0.5)
        
        contentView.clipsToBounds = false
        
        contentView.addSubview(self.song)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - Layout Subviews
    override func layoutSubviews() {
        super.layoutSubviews()
    
        NSLayoutConstraint.activate([
            song.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            song.widthAnchor.constraint(equalTo: contentView.widthAnchor),
            song.heightAnchor.constraint(equalTo: contentView.heightAnchor)
        ])
    }
 
    //MARK: - Configuration
    ///Prepares the cell to be reused
    override func prepareForReuse() {
        super.prepareForReuse()
//        self.removeFromSuperview()
    }
    
}
