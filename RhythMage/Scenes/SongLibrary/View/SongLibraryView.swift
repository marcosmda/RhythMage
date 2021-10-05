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
        table.register(SongLibraryOwnedSongsCell.self, forCellReuseIdentifier: SongLibraryOwnedSongsCell.reusableIdentifier)
        table.backgroundColor = .clear
        table.translatesAutoresizingMaskIntoConstraints = false
        table.separatorStyle = .none
        return table
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = .white
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
