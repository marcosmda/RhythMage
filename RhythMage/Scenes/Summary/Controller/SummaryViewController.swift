//
//  SummaryViewController.swift
//  RhythMage
//
//  Created by Lucas Frazão on 20/10/21.
//

import UIKit

protocol SummaryViewDelegate {
    func 
}

class SummaryViewController: BaseViewController<SummaryView> {
    
    var headerView: SummaryHeaderView?
    let songMock = SongMock()
    
    //MARK: - Initializers
    init(){
        let view = SummaryView(frame: UIScreen.main.bounds, with: ["UserPhoto-Test", "UserPhoto-Test", "UserPhoto-Test"])
        super.init(mainView: view)
        headerView = SummaryHeaderView(frame: .zero, songText: songMock.models[0].songName, artistText: songMock.models[0].artistName)
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        self.navigationItem.leftBarButtonItem =  self.mainView.rankingButton
        self.navigationItem.rightBarButtonItem = self.mainView.shareButton
        
    }
    
    override func viewDidLayoutSubviews() {
        self.navigationItem.titleView = headerView
    }

}
