//
//  HeadphonerViewController.swift
//  RhythMage
//
//  Created by Lucas Frazão on 26/10/21.
//

import UIKit

class HeadphonerViewController: BaseViewController<HeadphoneRecomendationView> {

    typealias Factory = TutorialSceneFactory
    let factory: Factory
    
    init(factory: Factory) {
        self.factory = factory
        let view = HeadphoneRecomendationView()
        super.init(mainView: view)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    override func viewDidAppear(_ animated: Bool) {
        Timer.scheduledTimer(timeInterval: 5, target: self, selector: #selector(authorizeSegue), userInfo: nil, repeats: false)
    }
    
    @objc private func authorizeSegue() {
        let transition = CATransition()
        transition.duration = 0.5
        transition.timingFunction = CAMediaTimingFunction(name: CAMediaTimingFunctionName.easeInEaseOut)
        transition.type = CATransitionType.fade
        self.navigationController?.view.layer.add(transition, forKey: nil)
        self.navigationController?.pushViewController(factory.createTutorialScene(), animated: false)
    }
}
