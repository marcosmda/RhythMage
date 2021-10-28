//
//  RecordingViewController.swift
//  RhythMage
//
//  Created by Marcos Vinicius Majeveski De Angeli on 13/10/21.
//

import UIKit
import SpriteKit
import GameplayKit
import RealmSwift

class RecordingViewController: BaseGameViewController<RecordingScene> {
    
    //MARK: - Properties
    
    //MARK: - Injected Properties
    var audioController: AudioController
    let realm: Realm
    
    //MARK: - Initialization
    init(realm: Realm, audioController: AudioController) {
        self.realm = realm
        self.audioController = audioController
        self.audioController.updateUrl(fileName: "fairy-tale-waltz", fileType: "mp3")
        
        //Calls super.init using teh screen's frame to create an SKView for the SKScene
        super.init(mainScene: RecordingScene(size: UIScreen.main.bounds.size))
        
        //AudioController delegate setup and start
        self.audioController.delegates.append(self)
        audioController.start(playing: true)
        
        self.mainScene.sceneDelegate = self
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - Methods

}

extension RecordingViewController: AudioControllerDelegate {
    func audioFinished() {
        dump("Audio Finished")
        do {
            try realm.write{
                realm.add(mainScene.tileInteractions)
            }
        } catch {
            
        }
    }
}


extension RecordingViewController: RecordingSceneDelegate {
    func pauseButtonTouched() {
        audioController.toggle()
    }
}
