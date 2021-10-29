//
//  GameViewController+GameDisplayView.swift
//  RhythMage
//
//  Created by Bruna Costa on 29/10/21.
//

import Foundation
import UIKit

extension GameViewController {
    
    func initGameDisplayView(){
        gameDisplayView = GameDisplayView(frame: self.mainView.frame)
        gameDisplayView.delegate = self
        self.mainView.addSubview(gameDisplayView)
        
    }
}
