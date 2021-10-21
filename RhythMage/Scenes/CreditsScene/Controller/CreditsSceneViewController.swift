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
    
    
    override func viewDidLoad() {
      super.viewDidLoad()
       
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        ableToPlay = true
        
        let bool = true
        if bool {
            self.navigationItem.title = "CREDITS"
            let attributes = [NSAttributedString.Key.font: UIFont(name: "Inika-Bold", size: 25)!, NSAttributedString.Key.foregroundColor: UIColor.white]
            self.navigationController?.navigationBar.titleTextAttributes = attributes
            self.navigationItem.leftBarButtonItem = self.mainView.backButton
        }
        
        
}
    
    init ()
    {
        super.init(mainView: CreditsView())
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func onBackButtonPush() {
        //navigationController?.pushViewController(factory.createSettingsScene(), animated: true)
    }
}
