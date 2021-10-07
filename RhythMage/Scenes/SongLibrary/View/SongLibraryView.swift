//
//  SongLibraryView.swift
//  RhythMage
//
//  Created by Juliana Prado on 05/10/21.
//

import UIKit

class SongLibraryView: UIView{
    
    //MARK: - Properties
    var delegate: SongLibraryViewDelegate?
    
    //MARK: - Properties
    let tableView: UITableView = {
        let table = UITableView(frame: .zero, style: .grouped)
        table.register(SongLibraryUnlockedSongCell.self, forCellReuseIdentifier: SongLibraryUnlockedSongCell.reusableIdentifier)
        table.register(SongLibraryLockedSongCell.self, forCellReuseIdentifier: SongLibraryLockedSongCell.reusableIdentifier)
        table.backgroundColor = .white
        table.translatesAutoresizingMaskIntoConstraints = false
        table.separatorStyle = .none
        return table
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = .white
        setupHiararchy()
        setupLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupHiararchy() {
        self.addSubview(tableView)
    }
    
    func setupLayout(){
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: self.layoutMarginsGuide.topAnchor),
            tableView.bottomAnchor.constraint(equalTo: self.layoutMarginsGuide.bottomAnchor),
            tableView.leadingAnchor.constraint(equalTo: self.layoutMarginsGuide.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: self.layoutMarginsGuide.trailingAnchor),

        ])
    }
    
    
}
