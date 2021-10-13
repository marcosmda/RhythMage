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
    
    //MARK: - Initializers
    init(){
        let view = SongLibraryView()
        super.init(mainView: view)
        mainView.tableView.delegate = self
        mainView.tableView.dataSource = self
        
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - View Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
    
    //MARK: - Methods
    ///Function configure adds songs to the mock user: User.
    func configure(){
//        user.setCompletedSong(songId: "Happier than Ever", songScore: 423422)
        models[0].unlock()
        models[1].unlock()
        models[2].unlock()
        user.completed["11"] = 33333
//        user.setCompletedSong(songId: "Sweet but Psycho", songScore: 342444)
//        user.setCompletedSong(songId: "A Concert Six Months From Now", songScore: 34353535)
    }
    
}

//MARK: - Extension UITableViewDelegate
extension SongLibraryViewController: UITableViewDelegate{

    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerView = UIView()
        headerView.backgroundColor = self.view.backgroundColor
        return headerView
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 2
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        let song = models[indexPath.section].getUnlock()
        switch song.self {
        case true:
            return 82.00
        case false:
            return 61.00
        }
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let song = models[indexPath.section].getUnlock()
        switch song.self {
        case true:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: SongLibraryUnlockedSongCell.reusableIdentifier, for: indexPath) as? SongLibraryUnlockedSongCell else {
                return UITableViewCell()
            }
            cell.configure(with: models[indexPath.section], and: user)
            return cell
        case false:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: SongLibraryLockedSongCell.reusableIdentifier, for: indexPath) as? SongLibraryLockedSongCell else {
                return UITableViewCell()
            }
            cell.configure(with: models[indexPath.section], and: user)
            return cell
        }
    }


    func numberOfSections(in tableView: UITableView) -> Int {
        return models.count
    }

    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return "Your Songs"
    }

}

//MARK: - Extension UITableViewDataSource
extension SongLibraryViewController: UITableViewDataSource{

    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        cell.layer.cornerRadius = 10
        cell.layer.masksToBounds = true
        cell.layer.borderWidth = 2
        cell.accessoryType = UITableViewCell.AccessoryType.none

        let borderColor: UIColor = UIColor.white
        cell.layer.borderColor = borderColor.cgColor
        cell.selectionStyle = .none

        let selectedView: UIView = UIView(frame: cell.frame)
        selectedView.layer.cornerRadius = 10
        selectedView.layer.masksToBounds = true
        selectedView.layer.borderWidth = 0
        selectedView.layer.borderColor = UIColor.white.cgColor
        selectedView.backgroundColor = UIColor.black
        cell.selectedBackgroundView = selectedView
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("selected a row")
    }


}
