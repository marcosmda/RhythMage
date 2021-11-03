//
//  TutorialViewController.swift
//  RhythMage
//
//  Created by Lucas Frazão on 25/10/21.
//

import UIKit
import AVFAudio


class TutorialViewController: BaseViewController<TutorialView> {
    
    let video: Video?
    
    var ellapsedKeys: [Double] = []
    
    typealias Factory = CameraSetupSceneFactory & SmileToUnlockFactory
    let factory: Factory
    
    init(factory: Factory) {
        self.factory = factory
        video = Video.setOnboarding()
        let view = TutorialView(video: video!)
        super.init(mainView: view)
        mainView.videoDelegate = self
        setupTimeStamps()

    }
    
    func setupTimeStamps() {
    
        let sorted = video!.subtitles.sorted {$0.key < $1.key}
        
        for element in sorted {
            ellapsedKeys.append(element.key)
            
        }
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        if let navigationController = self.navigationController {
            navigationController.navigationBar.isHidden = true
        }
        mainView.playVideo(with: video?.title ?? "erro")
    }
    
    

}

extension TutorialViewController: TutorialViewDelegate {
   
    func didTapSkipButton() {
        UserDefaults.standard.set(true, forKey: "Skip")
        let transition = CATransition()
        transition.duration = 0.5
        transition.timingFunction = CAMediaTimingFunction(name: CAMediaTimingFunctionName.easeInEaseOut)
        transition.type = CATransitionType.fade
        self.navigationController?.view.layer.add(transition, forKey: nil)
        self.navigationController?.pushViewController(factory.createSmileToUnlockScene(), animated: false)
    }
    
    func updateSubtitles(currentTime: Double) {

        if ellapsedKeys.count == 0 {return}
        
            if  currentTime >= ellapsedKeys[0] {
                self.mainView.subtitle.text = self.video?.subtitles[self.ellapsedKeys[0]]
                UIView.animate(withDuration: 0.1, delay: 0.0, options: [.curveEaseInOut]) {
                    self.mainView.layoutIfNeeded()
                }
                ellapsedKeys.remove(at: 0)
            }
        
    }
    
    func didEndVideo() {
        let transition = CATransition()
        transition.duration = 0.5
        transition.timingFunction = CAMediaTimingFunction(name: CAMediaTimingFunctionName.easeInEaseOut)
        transition.type = CATransitionType.fade
        self.navigationController?.view.layer.add(transition, forKey: nil)
        self.navigationController?.pushViewController(factory.createCameraSetupScene(), animated: false)
    }
    
}
