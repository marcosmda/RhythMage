//
//  MainNavigationController.swift
//  RhythMage
//
//  Created by Lucas Frazão on 19/10/21.
//

import UIKit

class MainNavigationController: UINavigationController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override open var prefersStatusBarHidden: Bool {
        return true
    }
    
    

}

extension UINavigationController {
    
    public func setupTransitionStyle(_ transitionType: CATransitionType, with duration: Double) {
        
    }
    
}
