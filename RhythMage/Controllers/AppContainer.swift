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
    let audioController = AudioController()
    
    /// The Main Navigation Controller with the root set in SmileToUnlock
    lazy var navigationController = MainNavigationController(rootViewController: self.createHeadphoneWarningScene())
    let authenticatinController = AuthenticationController()
    
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
        return SongLibraryViewController(authenticationController: authenticatinController)
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
        return LoadingScreenViewController(authenticationController: authenticatinController)
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
        return SmileToUnlockController(factory: self, authenticationController: authenticatinController)
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
        return SummaryViewController(factory: self)
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
        return GameViewController(realm: realm, audioController: audioController, level: Level.mockedLevel())
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
        return SettingsViewController(factory: self, authenticationController: authenticatinController)
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

//MARK: - HeadphoneWarning
protocol HeadphoneWarningSceneFactory{
    /// Creates an instance of TutorialViewController to be used
    /// - Returns: An instance of TutorialViewController
    func createHeadphoneWarningScene() -> HeadphonerViewController
}

extension AppContainer: HeadphoneWarningSceneFactory{
    func createHeadphoneWarningScene() -> HeadphonerViewController {
        return HeadphonerViewController(factory: self)
    }
}

//MARK: - Tutorial
protocol TutorialSceneFactory{
    /// Creates an instance of TutorialViewController to be used
    /// - Returns: An instance of TutorialViewController
    func createTutorialScene() -> TutorialViewController
}

extension AppContainer: TutorialSceneFactory{
    func createTutorialScene() -> TutorialViewController {
        return TutorialViewController(factory: self)
    }
}

//MARK: - CameraSetupViewController
protocol CameraSetupSceneFactory{
    /// Creates an instance of TutorialViewController to be used
    /// - Returns: An instance of TutorialViewController
    func createCameraSetupScene() -> CameraSetupViewController
}

extension AppContainer: CameraSetupSceneFactory{
    func createCameraSetupScene() -> CameraSetupViewController {
        return CameraSetupViewController(factory: self)
    }
}

//MARK: - CameraCaptureViewController
protocol CameraCaptureSceneFactory{
    /// Creates an instance of TutorialViewController to be used
    /// - Returns: An instance of TutorialViewController
    func createCameraCaptureScene() -> CameraCaptureViewController
}

extension AppContainer: CameraCaptureSceneFactory{
    func createCameraCaptureScene() -> CameraCaptureViewController {
        return CameraCaptureViewController(factory: self)
    }
}
