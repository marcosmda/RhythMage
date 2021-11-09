//
//  AuthenticationController.swift
//  RhythMage
//
//  Created by Marcos Vinicius Majeveski De Angeli on 22/10/21.
//

import Realm
import GameKit
import RealmSwift

class AuthenticationController: GKGameCenterViewController {
    //MARK: Injected Properties
    let realm: Realm
    
    public var user: User = User()
    public var gkLocalPlayer: GKLocalPlayer = GKLocalPlayer()
    
    //MARK: - Initialization
    init(realm: Realm) {
        self.realm = realm
        super.init(nibName: nil, bundle: nil)
        
        self.user = loadUser()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - GameKit Methods
    func authenticateGKLocalPlayer(navigationController: UINavigationController){
        DispatchQueue.main.async {
            GKLocalPlayer.local.authenticateHandler = { viewController, error in
                
                if let viewController = viewController {
                    // Present the view controller so the player can sign in.
                    navigationController.present(viewController, animated: true, completion: nil)
                    return
                }
                
                if error != nil {
                    // Player could not be authenticated.
                    // Disable Game Center in the game.
                    //GKAccessPoint.shared.isActive = false
                    return
                }
                
                GKAccessPoint.shared.isActive = false
                
                self.gkLocalPlayer = GKLocalPlayer.local
                
                if self.user.id != self.gkLocalPlayer.gamePlayerID
                || self.user.name != self.gkLocalPlayer.displayName {
                    self.updateUser(for: "id", to: self.gkLocalPlayer.gamePlayerID)
                    self.updateUser(for: "name", to: self.gkLocalPlayer.displayName)
                }
                return
            }
        }
        
    }
    
    //MARK: - User Persistency Methods
    public func updateUserHighScore(for level: String, to score: String) {
        var highScore = 0
        var newScore = 0
        do {
            try highScore = Int(user.completed[level] ?? "0", format: IntegerFormatStyle<Int>.number)
            try newScore = Int(score, format: IntegerFormatStyle<Int>.number)
        } catch {dump("Error updating user score on Realm")}
        
        if highScore < newScore {
            do {
                try realm.write {
                    user.completed[level] = score
                }
            } catch {dump("Error updating user score on Realm")}
        }
    }
    
    public func updateUserSettings(for key: String, to value: Any) {
        do {
            try realm.write {
                self.user.settings[key] = value
            }
        } catch {dump("Error updating user settings on Realm")}
    }
    
    public func updateUser(for key: String, to value: Any) {
        do {
            try realm.write {
                user[key] = value
            }
        } catch {dump("Error updating user model on Realm")}
    }
    
    private func loadUser() -> User{
        guard let retrievedUser = realm.objects(User.self).first
        else { //Enters if not able to load a user, so probably is the first time
            let user = User()
            saveUser(user)
            return user
        }
        return retrievedUser
    }
    
    private func saveUser(_ user: User) {
        do {
            try realm.write {
                realm.add(user)
            }
        } catch {dump("Error trying to save user model on Realm")}
    }
    
}

extension AuthenticationController: GKGameCenterControllerDelegate {
    
    func openLeaderboard(with vc: UIViewController) {
        let viewController = GKGameCenterViewController(leaderboardID: "rhythmage.bestscores",
                                                        playerScope: .global,
                                                        timeScope: .allTime)
        viewController.gameCenterDelegate = self
        vc.present(viewController, animated: true, completion: nil)
    }
    
    func gameCenterViewControllerDidFinish(_ gameCenterViewController: GKGameCenterViewController) {
        gameCenterViewController.dismiss(animated: true)
    }
}
