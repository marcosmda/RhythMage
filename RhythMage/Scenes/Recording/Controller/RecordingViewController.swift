//
//  RecordingViewController.swift
//  RhythMage
//
//  Created by Marcos Vinicius Majeveski De Angeli on 13/10/21.
//

import UIKit
import SpriteKit
import GameplayKit

class RecordingViewController: BaseGameViewController<RecordingScene> {
    
    //MARK: - Properties
    var initialDelayTime: Double = 3.0
    
    //MARK: - Injected Properties
    var audioController: AudioController
    
    //MARK: - Initialization
    init(audioController: AudioController) {
        self.audioController = audioController
        self.audioController.updateUrl(fileName: "fairy-tale-waltz", fileType: "mp3")
        
        //Calls super.init using teh screen's frame to create an SKView for the SKScene
        super.init(mainScene: RecordingScene(size: UIScreen.main.bounds.size))
        
        //Creates and presents the GameScene
        mainScene.backgroundColor = .black
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - View LifeCycle Methods



    //MARK: - Methods

}
