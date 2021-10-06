//
//  SongLibraryViewController.swift
//  RhythMage
//
//  Created by Juliana Prado on 05/10/21.
//

import UIKit

class SongLibraryViewController: BaseViewController<SongLibraryView>{    
    
    //MARK: - Properties
    var models = [
        Level(id: "11", checkpointScores: CheckpointScores(bronze: 111.11, silver: 222.22, gold: 333.33, wizard: 444.44), sequences:[], song: "Sweet but Psycho", artist: "Ava Max"),
        Level(id: "22", checkpointScores: CheckpointScores(bronze: 111.11, silver: 222.22, gold: 333.33, wizard: 444.44), sequences:[], song: "Happier than Ever", artist: "Billie Eilish"),
        Level(id: "33", checkpointScores: CheckpointScores(bronze: 111.11, silver: 222.22, gold: 333.33, wizard: 444.44), sequences:[], song: "A Concert Six Months From Now", artist: "Finneas"),
        Level(id: "44", checkpointScores: CheckpointScores(bronze: 111.11, silver: 222.22, gold: 333.33, wizard: 444.44), sequences:[], song: "Industry Baby", artist: "Lil Nas X"),
        Level(id: "55", checkpointScores: CheckpointScores(bronze: 111.11, silver: 222.22, gold: 333.33, wizard: 444.44), sequences:[], song: "Angel Baby", artist: "Troye Sivan")
    ]
    
    var user = User(id: "66", name: "Pessoa")
    
    override init(mainView: SongLibraryView) {
        super.init(mainView: SongLibraryView())
        
        mainView.tableView.delegate = self
        
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

extension SongLibraryViewController: UITableViewDelegate{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return models.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let song = models[indexPath.section].getUnlock()
        
        switch song.self {
        case true:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: SongLibraryOwnedSongsCell.reusableIdentifier, for: indexPath) as? SongLibraryOwnedSongsCell else {
                return UITableViewCell()
            }
            cell.configure(with: models[indexPath.section], and: user)
            return cell
        case false:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: SongLibraryOwnedSongsCell.reusableIdentifier, for: indexPath) as? SongLibraryOwnedSongsCell else {
                return UITableViewCell()
            }
            cell.configure(with: models[indexPath.section], and: user)
            return cell
        }
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return "Your Songs"
    }
    
    
}

extension SongLibraryViewController: UITableViewDataSource{
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        cell.layer.cornerRadius = 10
        cell.layer.masksToBounds = true
        cell.layer.borderWidth = 2
        
        let borderColor: UIColor = UIColor.white
        cell.layer.borderColor = borderColor.cgColor
        cell.selectionStyle = .none
        
        let selectedView: UIView = UIView(frame: cell.frame)
        selectedView.layer.cornerRadius = 10
        selectedView.layer.masksToBounds = true
        selectedView.layer.borderWidth = 2
        selectedView.layer.borderColor = UIColor.white.cgColor
        selectedView.backgroundColor = UIColor.black
        cell.selectedBackgroundView = selectedView
    }
    
    
    
}
