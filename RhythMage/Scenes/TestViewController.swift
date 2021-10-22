//
//  TestViewController.swift
//  RhythMage
//
//  Created by Juliana Prado on 22/10/21.
//

import UIKit

class TestViewController: BaseViewController<TesteView> {
    
    typealias Factory = SmileToUnlockFactory
    let factory: Factory
    
    //MARK: - Initializers
    init (factory: Factory) {
        self.factory = factory
        super.init(mainView: TesteView())
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
