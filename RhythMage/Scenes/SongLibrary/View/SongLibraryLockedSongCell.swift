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
        imageView.tintColor = .black
        imageView.image = UIImage(systemName: "play.circle.fill")
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    ///"unlock by scoring" label
    private let unlockByLabel: DynamicLabel = {
       let label = DynamicLabel()
        label.font = UIFont(name: "Inika-Bold", size: 18)
        label.numberOfLines = 1
        return label
    }()
    ///"xxxx points" Label
    private let pointsLabel: DynamicLabel = {
       let label = DynamicLabel()
        label.font = UIFont(name: "Inika-Bold", size: 18)
        label.numberOfLines = 2
        return label
    }()
    
}
