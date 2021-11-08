//
//  LoadingScreenViewController.swift
//  RhythMage
//
//  Created by Juliana Prado on 13/10/21.
//

import UIKit

class LoadingScreenViewController: BaseViewController<LoadingScreenView> {
    //MARK: Injected Properties
    let authenticationController: AuthenticationController
    
    var user: User {
        return authenticationController.user
    }
    
    //MARK: - Initializers
    init(authenticationController: AuthenticationController){
        self.authenticationController = authenticationController
        let view = LoadingScreenView()
        super.init(mainView: view)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - View Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        mainView.backgroundColor = .black
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
    
}
