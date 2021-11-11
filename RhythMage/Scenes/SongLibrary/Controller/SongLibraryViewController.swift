//
//  SongLibraryViewController.swift
//  RhythMage
//
//  Created by Juliana Prado on 05/10/21.
//

import UIKit

protocol SongLibraryDelegate {
    func backButtonAction()
    func openLeaderboards()
}

class SongLibraryViewController: BaseViewController<SongLibraryView>, SongLibraryDelegate, UIGestureRecognizerDelegate{
    //MARK: Injected Properties
    let authenticationController: AuthenticationController
    var levels: [Level]
    
    private var didStoppedSong: Bool = false
    
    //MARK: - Properties
    
    // TO-DO: Remove mock from controller!
    var models = [
        Level(id: "level1", checkpointScores: CheckpointScores(bronze: 111.11, silver: 222.22, gold: 333.33, wizard: 444.44), sequences:[], song: "Fairytale Waltz", artist: "AudioJungle"),
        Level(id: "level2", checkpointScores: CheckpointScores(bronze: 111.11, silver: 222.22, gold: 333.33, wizard: 444.44), sequences:[], song: "Industry Baby", artist: "Lil Nas X"),
        Level(id: "level3", checkpointScores: CheckpointScores(bronze: 111.11, silver: 222.22, gold: 333.33, wizard: 444.44), sequences:[], song: "Angel Baby", artist: "Troye Sivan")
    ]
    
    var user: User {
        return authenticationController.user 
    }
    
    //MARK: - Initializers
    init(authenticationController: AuthenticationController, levels: [Level]){
        self.authenticationController = authenticationController
        self.levels = levels
        super.init(mainView: SongLibraryView())
        mainView.tableView.delegate = self
        mainView.tableView.dataSource = self
        mainView.delegate = self
        
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - View Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.leftBarButtonItem =  self.mainView.buttonBack
        self.navigationController?.interactivePopGestureRecognizer?.delegate = self
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationItem.titleView = mainView.titleNavBar
        
        guard let navBar = self.navigationController?.navigationBar else {fatalError("Navigation Controller does not exist")}
        
        navBar.tintColor = .white
        
        navBar.barStyle = .default
        navBar.isTranslucent = true
        
        let appearance = UINavigationBarAppearance()
        appearance.configureWithTransparentBackground()
        appearance.titleTextAttributes = [.foregroundColor: UIColor.white] // With a white background, make the title more readable.
        navigationItem.standardAppearance = appearance
        navigationItem.scrollEdgeAppearance = appearance
        navigationItem.compactAppearance = appearance
        
    }
    
    //MARK: - Methods
    ///Function configure adds songs to the mock user: User.
    func configure(){
        levels[0].unlock()
        levels[1].unlock()
       //models[2].unlock()
    }
    
    func backButtonAction() {
        self.navigationController?.popViewController(animated: true)
    }
    
    // TO-DO: Remove mock level from this function.
    func openLeaderboards() {
        authenticationController.openLeaderboard(with: self, with: models[0].getId())
    }
    
}

//MARK: - Extension UITableViewDelegate
extension SongLibraryViewController: UITableViewDelegate{
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        
        if section == 0 {
            
            let headerView = SongLibraryHeaderView(frame: CGRect.init(x: 0, y: 0, width: tableView.frame.width, height: 65), headerTitle: "Your Songs")
            
            return headerView
            
        } else if section == 1 { //3 {
            
            let headerView = SongLibraryHeaderView(frame: CGRect.init(x: 0, y: 0, width: tableView.frame.width, height: 65), headerTitle: "Song Shop")
            return headerView
            
        }
        
        else {
            let headerView = UIView()
            headerView.backgroundColor = .clear
            return headerView
        }
     
        
        }
    
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        
        if section == 0 || section == 1{//3 {
            return 65
        }
        
        else {
            return 2
        }
        
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
        let song = levels[indexPath.section].getUnlock()
        switch song.self {
        case true:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: SongLibraryUnlockedSongCell.reusableIdentifier, for: indexPath) as? SongLibraryUnlockedSongCell else {
                return UITableViewCell()
            }
            cell.song.libraryDelegate = self
            cell.song.configure(with: levels[indexPath.section], userModel: user)
            return cell
        case false:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: SongLibraryLockedSongCell.reusableIdentifier, for: indexPath) as? SongLibraryLockedSongCell else {
                return UITableViewCell()
            }
            cell.song.configure(with: levels[indexPath.section], userModel: user)
            return cell
        }
    }


    func numberOfSections(in tableView: UITableView) -> Int {
        return levels.count
    }

}

//MARK: - Extension UITableViewDataSource
extension SongLibraryViewController: UITableViewDataSource{

    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        cell.layer.cornerRadius = 20
        cell.layer.masksToBounds = true
        cell.layer.borderWidth = 2
        cell.accessoryType = UITableViewCell.AccessoryType.none

        let borderColor: UIColor = UIColor.white
        cell.layer.borderColor = borderColor.cgColor
        cell.selectionStyle = .none

        let selectedView: UIView = UIView(frame: cell.frame)
        selectedView.layer.cornerRadius = 20
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

extension SongLibraryViewController: SongLibraryViewDelegate{
    func didPlaySong(songName: String) {
        let cells = mainView.tableView.visibleCells
        for cell in cells {
            guard let cell = cell as? SongLibraryUnlockedSongCell else { return}
            if cell.song.isPlaying && cell.song.songTitleLabel.text != songName {
                    cell.song.togglePlaySong()
                }
            }
        }
    
    func didStopSong() {
        didStoppedSong = true
    }
}

