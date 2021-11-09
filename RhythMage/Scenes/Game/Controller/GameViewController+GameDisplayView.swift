//
//  GameViewController+GameDisplayView.swift
//  RhythMage
//
//  Created by Bruna Costa on 29/10/21.
//

import Foundation
import UIKit

extension GameViewController {
    
    func viewWillAppearGameDisplayView(){
        gameDisplayView = GameDisplayView(frame: self.mainView.frame, level: level)
        gameDisplayView.delegate = self
        self.mainView.addSubview(gameDisplayView)
        gameDisplayView.backgroundColor = .clear
    }
}
