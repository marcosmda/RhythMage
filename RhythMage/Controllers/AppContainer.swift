//
//  AppContainer.swift
//  RhythMage
//
//  Created by Marcos Vinicius Majeveski De Angeli on 05/10/21.
//

import Foundation

class AppContainer {
    var audioController = AudioController()
}

//MARK: - MainScene
protocol MainSceneFactory {
    /// Creates an instance of MainSceneViewController to be used
    /// - Returns: An instance of MainSceneViewController
    func createMainScene() -> MainSceneViewController
}

extension AppContainer: MainSceneFactory {
    func createMainScene() -> MainSceneViewController {
        return MainSceneViewController()
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

//MARK: - RecordingScene
protocol RecordingSceneFactory {
    /// Creates an instance of RecordingViewController to be used
    /// - Returns: An instance of RecordingViewController
    func createRecordingScene() -> RecordingViewController
}

extension AppContainer: RecordingSceneFactory {
    func createRecordingScene() -> RecordingViewController {
        return RecordingViewController(audioController: self.audioController)
    }
}
