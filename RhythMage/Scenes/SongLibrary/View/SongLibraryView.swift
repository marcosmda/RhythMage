//
//  SongLibraryView.swift
//  RhythMage
//
//  Created by Juliana Prado on 05/10/21.
//

import UIKit

class SongLibraryView: UIView {
    
    //MARK: - Properties
    //var delegate: SongLibraryViewDelegate?
    var delegate: SongLibraryDelegate?
    var gradientView = GradientBackgroundView()
    
    lazy var tableView: UITableView = {
        let table = UITableView(frame: .zero, style: .grouped)
        table.register(SongLibraryUnlockedSongCell.self, forCellReuseIdentifier: SongLibraryUnlockedSongCell.reusableIdentifier)
        table.register(SongLibraryLockedSongCell.self, forCellReuseIdentifier: SongLibraryLockedSongCell.reusableIdentifier)
        table.backgroundColor = .clear
        table.translatesAutoresizingMaskIntoConstraints = false
        table.separatorStyle = .none
        return table
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = .primary
        setupHiararchy()
        setupLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupHiararchy() {
        self.addSubview(gradientView)
        self.addSubview(tableView)
    }
    
    func setupLayout(){
        
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: self.layoutMarginsGuide.topAnchor),
            tableView.bottomAnchor.constraint(equalTo: self.bottomAnchor),
            tableView.leadingAnchor.constraint(equalTo: self.layoutMarginsGuide.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: self.layoutMarginsGuide.trailingAnchor)
        ])
        
        
    }
    
    override func layoutSubviews() {
        gradientView.translatesAutoresizingMaskIntoConstraints = false
        gradientView.topAnchor.constraint(equalTo: self.topAnchor).isActive = true
        gradientView.leadingAnchor.constraint(equalTo: self.leadingAnchor).isActive = true
        gradientView.trailingAnchor.constraint(equalTo: self.trailingAnchor).isActive = true
        gradientView.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive = true
        
        gradientView.setupGradient(with: self)
    }
    
    lazy var buttonBack: UIBarButtonItem = {
        let button = UIButton(frame: CGRect(x: 0, y: 0, width: 44, height: 44))
        button.backgroundColor = .white
        button.setImage(UIImage(systemName: "arrow.left"), for: .normal)
        button.tintColor = .label
        button.layer.cornerRadius = 20
        button.addTarget(self, action: #selector(backButtonAction), for: .touchUpInside)
        button.clipsToBounds = true
        let barButtonItem = UIBarButtonItem(customView: button)
        return barButtonItem
    }()
    
    @objc func backButtonAction(_sender: UIBarButtonItem) {
        delegate?.backButtonAction()
    }
    
}
