//
//  AppContainer.swift
//  RhythMage
//
//  Created by Marcos Vinicius Majeveski De Angeli on 05/10/21.
//

import Foundation
import RealmSwift

class AppContainer {
    /// The Main Navigation Controller with the root set in SmileToUnlock
    lazy var navigationController = MainNavigationController(rootViewController: self.createSmileToUnlockScene())
    let realm = try! Realm()
    var audioController = AudioController()
    
    init() {
        
    }
}

//MARK: - NavigationController
protocol NavigationControllerFactory {
    /// Creates an instance of NavigationController to be used
    /// - Returns: An instance of NavigationController
    func createNavigationController() -> MainNavigationController
}

extension AppContainer: NavigationControllerFactory {
    
    func createNavigationController() -> MainNavigationController {
        return navigationController
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

//MARK: - SmileToResume
protocol SmileToResumeFactory{
    /// Creates an instance of SmileToResumeViewController to be used
    /// - Returns: An instance of SmileToResumeViewController
    func createSmileToResumeScene() -> SmileToResumeViewController
}

extension AppContainer:SmileToResumeFactory{
    func createSmileToResumeScene() -> SmileToResumeViewController {
        return SmileToResumeViewController(factory: self)
    }
}

//MARK: - Summary
protocol SummaryFactory {
    /// Creates an instance of SummaryViewController to be used
    /// - Returns: An instance of SummaryViewController
    func createSummaryScene() -> SummaryViewController
}

extension AppContainer: SummaryFactory {
    func createSummaryScene() -> SummaryViewController {
        return SummaryViewController()
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
        return GameViewController(realm: realm, audioController: audioController, level: Level.mockedLevel(), factory: self)
    }
}

//MARK: - SettingsScene
protocol SettingsSceneFactory{
    /// Creates an instance of SettingsViewController to be used
    /// - Returns: An instance of SettingsViewController
    func createSettingsScene() -> SettingsViewController
}

extension AppContainer:SettingsSceneFactory{
    func createSettingsScene() -> SettingsViewController {
        return SettingsViewController(factory: self)
    }
}

//MARK: - CreditsScene
protocol CreditsSceneFactory{
    /// Creates an instance of CreditsSceneViewController to be used
    /// - Returns: An instance of CreditsSceneViewController
    func createCreditsScene() -> CreditsSceneViewController
}

extension AppContainer:CreditsSceneFactory{
    func createCreditsScene() -> CreditsSceneViewController {
        return CreditsSceneViewController(factory: self)
    }
}
