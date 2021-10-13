//
//  AppContainer.swift
//  RhythMage
//
//  Created by Marcos Vinicius Majeveski De Angeli on 05/10/21.
//

import Foundation

class AppContainer {
    
}

//MARK: - MainScene
protocol MainSceneFactory {
    /// Creates an instance of MainSceneViewController to be used
    /// - Returns: An instance of MainSceneViewController
    func createMainScene() -> MainSceneViewController
    /// Creates an instance of SongLibraryViewController to be used
    /// - Returns: An instance of SongLibraryViewController
    func createSongLibraryView() -> SongLibraryViewController
}

extension AppContainer: MainSceneFactory {
    func createMainScene() -> MainSceneViewController {
        return MainSceneViewController()
    }
    
    func createSongLibraryView() -> SongLibraryViewController {
        return SongLibraryViewController()
    }
}
