//
//  CreditsSceneViewController.swift
//  RhythMage
//
//  Created by Bruna Costa on 20/10/21.
//

import Foundation
import UIKit

protocol CreditsSceneDelegate {
    func onBackButtonPush()
}

class CreditsSceneViewController: BaseViewController<CreditsView>{
    
    var ableToPlay = false
    //MARK: To Do: Navigation of Scene
    //typealias Factory = SettingsSceneFactory
    //let factory: Factory
    
    
    override func viewDidLoad() {
      super.viewDidLoad()
       
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        ableToPlay = true
        
        let bool = true
        if bool {
            //self.navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor : UIColor.secondary, NSAttributedString.Key.fontinika(ofSize: 20)]
            self.navigationItem.leftBarButtonItem = self.mainView.backButton
        }
        
        
}
    
    init ()
    {
        super.init(mainView: CreditsView())
        //mainView.delegate = self
        //mainView.layoutSubviews()
        //setupGameKit()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func onBackButtonPush() {
        //navigationController?.pushViewController(factory.createSettingsScene(), animated: true)
    }
}
