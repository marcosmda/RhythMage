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
        //self.backgroundColor = UIColor.terciaryBackground
        self.backgroundColor = .clear
        
        self.addSubview(self.song)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - Layout Subviews
    override func layoutSubviews() {
        super.layoutSubviews()
    
        NSLayoutConstraint.activate([
            song.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            song.topAnchor.constraint(equalTo: self.layoutMarginsGuide.topAnchor),
            song.bottomAnchor.constraint(equalTo: self.layoutMarginsGuide.bottomAnchor),
            song.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            
        ])
    }
 
    //MARK: - Configuration
    ///Prepares the cell to be reused
    override func prepareForReuse() {
        super.prepareForReuse()
//        self.removeFromSuperview()
    }
    
}
