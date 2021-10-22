//
//  CreditsSceneViewController.swift
//  RhythMage
//
//  Created by Bruna Costa on 20/10/21.
//

import Foundation
import UIKit


class CreditsSceneViewController: BaseViewController<CreditsView>, UIGestureRecognizerDelegate, CreditsSceneDelegate{
    
    var ableToPlay = false

    typealias Factory = SettingsSceneFactory
    let factory: Factory
    
    override func viewDidLoad() {
      super.viewDidLoad()
        mainView.delegate = self
        self.navigationController?.interactivePopGestureRecognizer?.delegate = self
        self.navigationItem.leftBarButtonItem = self.mainView.backButton
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        ableToPlay = true
        
        let bool = true
        if bool {
            self.navigationItem.title = "CREDITS"
            let attributes = [NSAttributedString.Key.font: UIFont(name: "Inika-Bold", size: 25)!, NSAttributedString.Key.foregroundColor: UIColor.white]
            self.navigationController?.navigationBar.titleTextAttributes = attributes
            
        }
        
        
}
    
    init (factory:Factory)
    {
        self.factory = factory
        super.init(mainView: CreditsView())
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func onBackButtonPush() {
        self.navigationController?.popViewController(animated: true)
    }
}
