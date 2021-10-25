//
//  SummaryViewController.swift
//  RhythMage
//
//  Created by Lucas Frazão on 20/10/21.
//

import UIKit
import GameKit

protocol SummaryDelegate {
    func goToMainMenu()
    func goToSongLibrary()
    func goToLeaderboards()
}

class SummaryViewController: BaseViewController<SummaryView> {
    
    var headerView: SummaryHeaderView?
    let songMock = SongMock()
    
    typealias Factory = SummaryFactory & SongLibrarySceneFactory
    let factory: Factory
    
    //MARK: - Initializers
    init(factory:Factory){
        self.factory = factory
        let view = SummaryView(with: ["UserPhoto-Test", "UserPhoto-Test", "UserPhoto-Test"], points: 28456, message: "Magic in the air!")
        super.init(mainView: view)
        headerView = SummaryHeaderView(frame: .zero, songText: songMock.models[0].songName, artistText: songMock.models[0].artistName)
        mainView.delegate = self
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        self.navigationItem.leftBarButtonItem =  self.mainView.rankingButton
        self.navigationItem.rightBarButtonItem = self.mainView.shareButton
        setupGameKit()
    }
    
    override func viewDidLayoutSubviews() {
        self.navigationItem.titleView = headerView
    }
    
}

extension SummaryViewController: SummaryDelegate {
    
    func goToMainMenu() {
        self.navigationController?.popToRootViewController(animated: true)
    }
    
    func goToSongLibrary() {
        print("eu")
        self.navigationController?.pushViewController(factory.createSongLibraryScene(), animated: true)
    }
    
    func goToLeaderboards() {
        let viewController = GKGameCenterViewController(leaderboardID: "1.000",
                                                        playerScope: .global,
                                                        timeScope: .allTime)
        viewController.gameCenterDelegate = self
        present(viewController, animated: true, completion: nil)
    }
    
    
}


extension SummaryViewController: GKGameCenterControllerDelegate {
    
    func gameCenterViewControllerDidFinish(_ gameCenterViewController: GKGameCenterViewController) {
        gameCenterViewController.dismiss(animated:true)
    }
    
    func setupGameKit() {
        
        GKLocalPlayer.local.authenticateHandler = { viewController, error in
            
            if let viewController = viewController {
                // Present the view controller so the player can sign in.
                
                self.present(viewController, animated: true, completion: nil)
                
                return
            }
            
            if error != nil {
                // Player could not be authenticated.
                // Disable Game Center in the game.
                GKAccessPoint.shared.isActive = false
                return
            }
            
            // Player was successfully authenticated.
            // Check if there are any player restrictions before starting the game.
            
            if GKLocalPlayer.local.isUnderage {
                // Hide explicit game content.
            }
            
            if GKLocalPlayer.local.isMultiplayerGamingRestricted {
                // Disable multiplayer game features.
            }
            
            if GKLocalPlayer.local.isPersonalizedCommunicationRestricted {
                // Disable in game communication UI.
            }
            
            GKAccessPoint.shared.isActive = false
            
        }
        
        
        
    }

}

