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
        if mainView.subviews.contains(where: {$0.isKind(of: GameDisplayView.self)}) {
            let vc = self.mainView.subviews.filter{$0.isKind(of: GameDisplayView.self)}.last
            vc?.removeFromSuperview()
        }
        self.mainView.addSubview(gameDisplayView)
        gameDisplayView.backgroundColor = .clear
    }
}
