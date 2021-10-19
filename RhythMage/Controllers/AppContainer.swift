//
//  AppContainer.swift
//  RhythMage
//
//  Created by Marcos Vinicius Majeveski De Angeli on 05/10/21.
//

import Foundation
import RealmSwift

class AppContainer {
    let realm = try! Realm()
    var audioController = AudioController()
    
    init() {
        
    }
}

//MARK: - SongLibrary
protocol SongLibrarySceneFactory {
    /// Creates an instance of SongLibraryViewController to be used
    /// - Returns: An instance of SongLibraryViewController
    func createSongLibraryScene() -> SongLibraryViewController
}

extension AppContainer: SongLibrarySceneFactory {
    
    func createSongLibraryScene() -> SongLibraryViewController {
        return SongLibraryViewController()
    }

}

//MARK: - LoadingScene
protocol LoadingSceneFactory {
    /// Creates an instance of LoadingScreenViewController to be used
    /// - Returns: An instance of LoadingScreenViewController
    func createLoadingScreenScene() -> LoadingScreenViewController
}

extension AppContainer: LoadingSceneFactory {
    func createLoadingScreenScene() -> LoadingScreenViewController{
        return LoadingScreenViewController()
    }
}

//MARK: - RecordingScene
protocol RecordingSceneFactory {
    /// Creates an instance of RecordingViewController to be used
    /// - Returns: An instance of RecordingViewController
    func createRecordingScene() -> RecordingViewController
}

extension AppContainer: RecordingSceneFactory {
    func createRecordingScene() -> RecordingViewController {
        return RecordingViewController(realm: realm, audioController: self.audioController)
    }
}

//MARK: - SmileToUnlock
protocol SmileToUnlockFactory{
    /// Creates an instance of SmileToUnlockViewController to be used
    /// - Returns: An instance of SmileToUnlockViewController
    func createSmileToUnlockScene() -> SmileToUnlockController
}

extension AppContainer:SmileToUnlockFactory{
    func createSmileToUnlockScene() -> SmileToUnlockController {
        return SmileToUnlockController(factory: self)
    }
}

//MARK: - GameScene
protocol GameSceneFactory{
    /// Creates an instance of GameViewController to be used
    /// - Returns: An instance of GameViewController
    func createGameScene() -> GameViewController
}

extension AppContainer:GameSceneFactory{
    func createGameScene() -> GameViewController {
        return GameViewController
    }
}




