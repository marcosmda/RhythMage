//
//  GameViewController+LifeCycle.swift
//  RhythMage
//
//  Created by Bruna Costa on 29/10/21.
//

import Foundation
import UIKit

extension GameViewController {
    
    override func viewWillAppear(_ animated: Bool) {
        viewWillAppearGameScene()
        viewWillAppearFaceTracking()
        viewWillAppearAudioController()
        images = []
        counter = 3
        viewWillAppearCapture()
        viewWillAppearGameDisplayView()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        self.navigationController?.isNavigationBarHidden = true
        
        createTiles()
        timer = Timer.scheduledTimer(timeInterval: startDelayTime, target: self, selector: #selector(startAudio), userInfo: nil, repeats: false)
        mainScene.setVelocity(velocity: Float(scrollVelocity))
    }
    
    override func viewDidLayoutSubviews() {
        
        let position = mainScene.convertPoint(toView: CGPoint(x: mainScene.hitLine.position.x, y: mainScene.hitLine.position.y))
        
        let width = mainView.frame.width - 20
        let height: CGFloat = 23.00
        
        gameDisplayView.hitBarImage.frame = CGRect(x: position.x - width/2, y:  position.y - height / 2, width: width, height: height)
        
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        viewWillDesapearFaceTracking()
    }
    
}
