//
//  TutorialViewController.swift
//  RhythMage
//
//  Created by Lucas Frazão on 25/10/21.
//

import UIKit

class TutorialViewController: BaseViewController<TutorialView> {

    init() {
        let view = TutorialView()
        super.init(mainView: view)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

}
