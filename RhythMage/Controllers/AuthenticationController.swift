//
//  AuthenticationController.swift
//  RhythMage
//
//  Created by Marcos Vinicius Majeveski De Angeli on 22/10/21.
//

import GameKit

class AuthenticationController {
    
    public var user: User?
    
    //MARK: - Methods
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
                    self.user = User.empty()
                    return
                }
                
                GKAccessPoint.shared.isActive = true
                
                let id = GKLocalPlayer.local.gamePlayerID
                let name = GKLocalPlayer.local.displayName
                
                self.user = User(id: id, name: name)
                return
            }
        }
        
    }
}
