//
//  SettingsViewController.swift
//  RhythMage
//
//  Created by Bruna Costa on 19/10/21.
//

import Foundation
import UIKit

protocol SettingsDelegate {
    func onBackButtonPush()
    func onTermsOfUsePush()
    func onCreditsPush()
    func switchValueDidChange()
}

class SettingsViewController: BaseViewController<SettingsView>{
    
    var ableToPlay = false
    var safeArea: UILayoutGuide!
    //var user: User
    
    typealias Factory = SmileToUnlockFactory
    let factory: Factory
    //var sender: UISwitch
    
    //MARK: - Initializers
    init( factory: Factory){//user: User,
        //self.user = user
        self.factory = factory
        let view = SettingsView(frame: .zero)//, userSettings: user.userSettings)
        super.init(mainView: view)
        mainView.delegate = self
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
      super.viewDidLoad()
        //mainView.layoutSubviews()
        mainView.backgroundColor = .secondaryBackground
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        ableToPlay = true
        
        let bool = true
        if bool {
            self.navigationItem.title = "Settings"
            let attributes = [NSAttributedString.Key.font: UIFont(name: "Inika-Bold", size: 25)!, NSAttributedString.Key.foregroundColor: UIColor.white]
            self.navigationController?.navigationBar.titleTextAttributes = attributes
            self.navigationItem.leftBarButtonItem = self.mainView.backButton
        }
        
        
    }

    
    
}

extension SettingsViewController: SettingsDelegate {
    func onTermsOfUsePush() {
        // navigationController?.pushViewController(factory.createTermsOfUseScene(), animated: true)
    }
    
    func onCreditsPush() {
        //navigationController?.pushViewController(factory.createCreditsScene(), animated: true)
    }
    
    func switchValueDidChange() {
    }
    
    
    func onBackButtonPush() {
       // navigationController?.pushViewController(factory.createSmileToUnlockScene(), animated: true)
    }

}


