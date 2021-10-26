//
//  CameraSetupViewController.swift
//  RhythMage
//
//  Created by Lucas Frazão on 26/10/21.
//

import UIKit

class CameraSetupViewController: BaseViewController<CameraAccessView> {

    init() {
        let view = CameraAccessView()
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
