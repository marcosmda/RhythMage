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
    
    init() {
        video = Video.setOnboarding()
        let view = TutorialView(video: video!)
        super.init(mainView: view)
        mainView.videoDelegate = self
        setupTimeStamps()

    }
    
    func setupTimeStamps() {
        
      
        
        guard let subtitles = video?.subtitles.keys else {return}
        
        let sorted = video!.subtitles.sorted {$0.key < $1.key}
        
        for element in sorted {
            ellapsedKeys.append(element.key)
            
        }
        
        print(ellapsedKeys)
        
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
    
}
