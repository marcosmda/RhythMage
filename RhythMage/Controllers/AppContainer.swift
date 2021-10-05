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
}

extension AppContainer: MainSceneFactory {
    func createMainScene() -> MainSceneViewController {
        return MainSceneViewController()
    }
}
